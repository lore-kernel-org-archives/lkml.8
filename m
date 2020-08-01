Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A756DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DBF207BC
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaWHYaZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHAPJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:09:28 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D3C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 08:09:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so25243151qto.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AnUnEw7ce9H3qhe28a6R96K/BnlU0zb3g4leH5fYies=;
        b=IaWHYaZMB5TD+ZQcsllGb890DGQ658jE5DNKFYFaUPNsRW3ushkrkDfszkG+JwLfVT
         +DzHKRueuVVmG27M8CPJD+rGbb1T0yMJm+Fv+nfJLi+rDE1UaYbJucTI3yDXr7Renj9L
         659GJwCDctmyZ1N6NXXIlnLivYkuXXVXUXA3bxUVNC0X7GO/svm13WfelQGvCTCCbuNd
         sm6jls2Ql0UXm14BgPgt3SIjYWu4WmXf8DmMpVjvADqIGHY1Db/axR2Rzq5N7FWm9csT
         uRG4gh8n+PeionvH7r+6CHH9Ex4tNTkk47JTyyz6avJ7Vmdpp5U/W53a8sLLfQJEvYJH
         6uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AnUnEw7ce9H3qhe28a6R96K/BnlU0zb3g4leH5fYies=;
        b=TdmtRxCyjQOWrqWHX0gNtwzd1T5XymXlkEznL/jXNtpQFkQ6PfDUOqhmiJQEqpuxHU
         WTFAz6rXaYatfHYgkr+DN2ygup14pO1/TVdUC/I9Ev18vhk5UvnWeDdZJPQt3dKsl3VI
         KNFIvMdjKmuqQjx7TxqoX43Ry2+AmOrkt/Fhlyydcj1K6yFd4TzsMjIzzwrP6YQ1jVuQ
         ZIzy5BLIssf9eWQeQJE7DzMbFrQ5ab/2+v2I4cfRIcvWlt+0zYOlAHGmIsTPrOY5xXZj
         rb/Fom/9kUnTdhowcrOfFhqRwu761nJOHsDdXus65ccVYVjOzjUoXV+/jSlR+vwPwBvO
         50cg==
X-Gm-Message-State: AOAM531o7zfbuASK1R3q5NPuyXP2t+Rg09l2sNUhxWNBMsq+Xd4Sx45m
        CmGf1HKiCN6tQMPE+U+sHg==
X-Google-Smtp-Source: ABdhPJwVrd8QjBPMSvl4se7MrhK152HJ7JbrprmBFUZb5nWD8fw1Ls3Gv2euWj8SmTqBJwDRXlex5w==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr9131991qtn.241.1596294566246;
        Sat, 01 Aug 2020 08:09:26 -0700 (PDT)
Received: from PWN (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id p4sm12300599qkj.135.2020.08.01.08.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 08:09:25 -0700 (PDT)
Date:   Sat, 1 Aug 2020 11:09:19 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
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
Message-ID: <20200801150919.GA229082@PWN>
References: <20200727213644.328662-1-yepeilin.cs@gmail.com>
 <20200801020841.227522-1-yepeilin.cs@gmail.com>
 <20200801110646.GA1705@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801110646.GA1705@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 02:06:46PM +0300, Dmitry V. Levin wrote:
> On Fri, Jul 31, 2020 at 10:08:41PM -0400, Peilin Ye wrote:
> > ptrace_get_syscall_info() is potentially copying uninitialized stack
> > memory to userspace, since the compiler may leave a 3-byte hole near the
> > beginning of `info`. Fix it by adding a padding field to `struct
> > ptrace_syscall_info`.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > ---
> > Change in v2:
> >     - Add a padding field to `struct ptrace_syscall_info`, instead of
> >       doing memset() on `info`. (Suggested by Dmitry V. Levin
> >       <ldv@altlinux.org>)
> > 
> > Reference: https://lwn.net/Articles/417989/
> > 
> > $ # before:
> > $ pahole -C "ptrace_syscall_info" kernel/ptrace.o
> > struct ptrace_syscall_info {
> > 	__u8                       op;                   /*     0     1 */
> > 
> > 	/* XXX 3 bytes hole, try to pack */
> > 
> > 	__u32                      arch __attribute__((__aligned__(4))); /*     4     4 */
> > 	__u64                      instruction_pointer;  /*     8     8 */
> > 	__u64                      stack_pointer;        /*    16     8 */
> > 	union {
> > 		struct {
> > 			__u64      nr;                   /*    24     8 */
> > 			__u64      args[6];              /*    32    48 */
> > 		} entry;                                 /*    24    56 */
> > 		struct {
> > 			__s64      rval;                 /*    24     8 */
> > 			__u8       is_error;             /*    32     1 */
> > 		} exit;                                  /*    24    16 */
> > 		struct {
> > 			__u64      nr;                   /*    24     8 */
> > 			__u64      args[6];              /*    32    48 */
> > 			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> > 			__u32      ret_data;             /*    80     4 */
> > 		} seccomp;                               /*    24    64 */
> > 	};                                               /*    24    64 */
> > 
> > 	/* size: 88, cachelines: 2, members: 5 */
> > 	/* sum members: 85, holes: 1, sum holes: 3 */
> > 	/* forced alignments: 1, forced holes: 1, sum forced holes: 3 */
> > 	/* last cacheline: 24 bytes */
> > } __attribute__((__aligned__(8)));
> > $
> > $ # after:
> > $ pahole -C "ptrace_syscall_info" kernel/ptrace.o
> > struct ptrace_syscall_info {
> > 	__u8                       op;                   /*     0     1 */
> > 	__u8                       pad[3];               /*     1     3 */
> > 	__u32                      arch __attribute__((__aligned__(4))); /*     4     4 */
> > 	__u64                      instruction_pointer;  /*     8     8 */
> > 	__u64                      stack_pointer;        /*    16     8 */
> > 	union {
> > 		struct {
> > 			__u64      nr;                   /*    24     8 */
> > 			__u64      args[6];              /*    32    48 */
> > 		} entry;                                 /*    24    56 */
> > 		struct {
> > 			__s64      rval;                 /*    24     8 */
> > 			__u8       is_error;             /*    32     1 */
> > 		} exit;                                  /*    24    16 */
> > 		struct {
> > 			__u64      nr;                   /*    24     8 */
> > 			__u64      args[6];              /*    32    48 */
> > 			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
> > 			__u32      ret_data;             /*    80     4 */
> > 		} seccomp;                               /*    24    64 */
> > 	};                                               /*    24    64 */
> > 
> > 	/* size: 88, cachelines: 2, members: 6 */
> > 	/* forced alignments: 1 */
> > 	/* last cacheline: 24 bytes */
> > } __attribute__((__aligned__(8)));
> > $ _
> > 
> >  include/uapi/linux/ptrace.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> > index a71b6e3b03eb..a518ba514bac 100644
> > --- a/include/uapi/linux/ptrace.h
> > +++ b/include/uapi/linux/ptrace.h
> > @@ -81,6 +81,7 @@ struct seccomp_metadata {
> >  
> >  struct ptrace_syscall_info {
> >  	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> > +	__u8 pad[3];
> >  	__u32 arch __attribute__((__aligned__(sizeof(__u32))));
> >  	__u64 instruction_pointer;
> >  	__u64 stack_pointer;
> 
> Funnily enough, but in first editions of PTRACE_GET_SYSCALL_INFO
> patchset [1] this was looking very similar:
> 
> +struct ptrace_syscall_info {
> +	__u8 op;        /* PTRACE_SYSCALL_INFO_* */
> +	__u8 __pad0[3];
> +	__u32 arch;
> 
> But later we decided [2][3] to replace the pad with a hole.
> 
> Note that the sole purpose of the __aligned__ attribute on the field that
> follows the hole is to guarantee that the hole has the same size across
> architectures.  As this hole is being replaced back with a pad, that
> __aligned__ attribute is no longer needed and can be omitted along with
> adding the pad.

Ah, I see. I will remove that in v3.

Thank you,
Peilin Ye

> [1] https://lore.kernel.org/linux-api/20181125022150.46258a20@akathisia/
> [2] https://lore.kernel.org/linux-api/20181211162305.GA480@altlinux.org/
> [3] https://lore.kernel.org/linux-api/20181213171833.GA5240@altlinux.org/
> 
> 
> -- 
> ldv
