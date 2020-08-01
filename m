Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C303C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63E52087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 11:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgHALGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 07:06:49 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:50416 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgHALGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 07:06:49 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A619272CCE9;
        Sat,  1 Aug 2020 14:06:46 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 98AA37CFC00; Sat,  1 Aug 2020 14:06:46 +0300 (MSK)
Date:   Sat, 1 Aug 2020 14:06:46 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <evgsyr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] ptrace: Prevent
 kernel-infoleak in ptrace_get_syscall_info()
Message-ID: <20200801110646.GA1705@altlinux.org>
References: <20200727213644.328662-1-yepeilin.cs@gmail.com>
 <20200801020841.227522-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801020841.227522-1-yepeilin.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:08:41PM -0400, Peilin Ye wrote:
> ptrace_get_syscall_info() is potentially copying uninitialized stack
> memory to userspace, since the compiler may leave a 3-byte hole near the
> beginning of `info`. Fix it by adding a padding field to `struct
> ptrace_syscall_info`.
> 
> Cc: stable@vger.kernel.org
> Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> Change in v2:
>     - Add a padding field to `struct ptrace_syscall_info`, instead of
>       doing memset() on `info`. (Suggested by Dmitry V. Levin
>       <ldv@altlinux.org>)
> 
> Reference: https://lwn.net/Articles/417989/
> 
> $ # before:
> $ pahole -C "ptrace_syscall_info" kernel/ptrace.o
> struct ptrace_syscall_info {
> 	__u8                       op;                   /*     0     1 */
> 
> 	/* XXX 3 bytes hole, try to pack */
> 
> 	__u32                      arch __attribute__((__aligned__(4))); /*     4     4 */
> 	__u64                      instruction_pointer;  /*     8     8 */
> 	__u64                      stack_pointer;        /*    16     8 */
> 	union {
> 		struct {
> 			__u64      nr;                   /*    24     8 */
> 			__u64      args[6];              /*    32    48 */
> 		} entry;                                 /*    24    56 */
> 		struct {
> 			__s64      rval;                 /*    24     8 */
> 			__u8       is_error;             /*    32     1 */
> 		} exit;                                  /*    24    16 */
> 		struct {
> 			__u64      nr;                   /*    24     8 */
> 			__u64      args[6];              /*    32    48 */
> 			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> 			__u32      ret_data;             /*    80     4 */
> 		} seccomp;                               /*    24    64 */
> 	};                                               /*    24    64 */
> 
> 	/* size: 88, cachelines: 2, members: 5 */
> 	/* sum members: 85, holes: 1, sum holes: 3 */
> 	/* forced alignments: 1, forced holes: 1, sum forced holes: 3 */
> 	/* last cacheline: 24 bytes */
> } __attribute__((__aligned__(8)));
> $
> $ # after:
> $ pahole -C "ptrace_syscall_info" kernel/ptrace.o
> struct ptrace_syscall_info {
> 	__u8                       op;                   /*     0     1 */
> 	__u8                       pad[3];               /*     1     3 */
> 	__u32                      arch __attribute__((__aligned__(4))); /*     4     4 */
> 	__u64                      instruction_pointer;  /*     8     8 */
> 	__u64                      stack_pointer;        /*    16     8 */
> 	union {
> 		struct {
> 			__u64      nr;                   /*    24     8 */
> 			__u64      args[6];              /*    32    48 */
> 		} entry;                                 /*    24    56 */
> 		struct {
> 			__s64      rval;                 /*    24     8 */
> 			__u8       is_error;             /*    32     1 */
> 		} exit;                                  /*    24    16 */
> 		struct {
> 			__u64      nr;                   /*    24     8 */
> 			__u64      args[6];              /*    32    48 */
> 			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> 			__u32      ret_data;             /*    80     4 */
> 		} seccomp;                               /*    24    64 */
> 	};                                               /*    24    64 */
> 
> 	/* size: 88, cachelines: 2, members: 6 */
> 	/* forced alignments: 1 */
> 	/* last cacheline: 24 bytes */
> } __attribute__((__aligned__(8)));
> $ _
> 
>  include/uapi/linux/ptrace.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index a71b6e3b03eb..a518ba514bac 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -81,6 +81,7 @@ struct seccomp_metadata {
>  
>  struct ptrace_syscall_info {
>  	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> +	__u8 pad[3];
>  	__u32 arch __attribute__((__aligned__(sizeof(__u32))));
>  	__u64 instruction_pointer;
>  	__u64 stack_pointer;

Funnily enough, but in first editions of PTRACE_GET_SYSCALL_INFO
patchset [1] this was looking very similar:

+struct ptrace_syscall_info {
+	__u8 op;        /* PTRACE_SYSCALL_INFO_* */
+	__u8 __pad0[3];
+	__u32 arch;

But later we decided [2][3] to replace the pad with a hole.

Note that the sole purpose of the __aligned__ attribute on the field that
follows the hole is to guarantee that the hole has the same size across
architectures.  As this hole is being replaced back with a pad, that
__aligned__ attribute is no longer needed and can be omitted along with
adding the pad.

[1] https://lore.kernel.org/linux-api/20181125022150.46258a20@akathisia/
[2] https://lore.kernel.org/linux-api/20181211162305.GA480@altlinux.org/
[3] https://lore.kernel.org/linux-api/20181213171833.GA5240@altlinux.org/


-- 
ldv
