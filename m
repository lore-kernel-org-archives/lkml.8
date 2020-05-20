Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C2A207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgETLAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:00:13 -0400
Received: from ozlabs.org ([203.11.71.1]:35791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgETLAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:00:11 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49RqXT49tzz9sV0; Wed, 20 May 2020 21:00:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mikey@neuling.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        mpe@ellerman.id.au
Cc:     jolsa@kernel.org, fweisbec@gmail.com, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org, oleg@redhat.com,
        peterz@infradead.org, apopple@linux.ibm.com,
        linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
In-Reply-To: <20200514111741.97993-1-ravi.bangoria@linux.ibm.com>
References: <20200514111741.97993-1-ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v6 00/16] powerpc/watchpoint: Preparation for more than one watchpoint
Message-Id: <158997215393.943180.1297096710553012191.b4-ty@ellerman.id.au>
Date:   Wed, 20 May 2020 21:00:08 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 16:47:25 +0530, Ravi Bangoria wrote:
> So far, powerpc Book3S code has been written with an assumption of
> only one watchpoint. But Power10[1] is introducing second watchpoint
> register (DAWR). Even though this patchset does not enable 2nd DAWR,
> it makes the infrastructure ready so that enabling 2nd DAWR should
> just be a matter of changing count.
> 
> Existing functionality works fine with the patchset. I've tested it
> with perf, ptrace(gdb), xmon. All hw-breakpoint selftests are passing
> as well. And I've build tested for 8xx and 'AMCC 44x, 46x or 47x'.
> 
> [...]

Applied to powerpc/next.

[01/16] powerpc/watchpoint: Rename current DAWR macros
        https://git.kernel.org/powerpc/c/09f82b063aa9c248a3ef919aeec361054e7b044a
[02/16] powerpc/watchpoint: Add SPRN macros for second DAWR
        https://git.kernel.org/powerpc/c/4a4ec2289a5d748cb64ff67ca8d74535a76a8436
[03/16] powerpc/watchpoint: Introduce function to get nr watchpoints dynamically
        https://git.kernel.org/powerpc/c/a6ba44e8799230e36c8ab06fda7f77f421e9e795
[04/16] powerpc/watchpoint/ptrace: Return actual num of available watchpoints
        https://git.kernel.org/powerpc/c/45093b382e0ac25c206b4dcd210c6be1f5e56e60
[05/16] powerpc/watchpoint: Provide DAWR number to set_dawr
        https://git.kernel.org/powerpc/c/a18b834625d345bfa89c4e2754dd6cbb0133c4d7
[06/16] powerpc/watchpoint: Provide DAWR number to __set_breakpoint
        https://git.kernel.org/powerpc/c/4a8a9379f2af4c9928529b3959bc2d8f7023c6bc
[07/16] powerpc/watchpoint: Get watchpoint count dynamically while disabling them
        https://git.kernel.org/powerpc/c/c2919132734f29a7a33e1339bef8a67b11f322eb
[08/16] powerpc/watchpoint: Disable all available watchpoints when !dawr_force_enable
        https://git.kernel.org/powerpc/c/22a214e461c5cc9428b86915d9cfcf84c6e11ad7
[09/16] powerpc/watchpoint: Convert thread_struct->hw_brk to an array
        https://git.kernel.org/powerpc/c/303e6a9ddcdc168e92253c78cdb4bbe1e10d78b3
[10/16] powerpc/watchpoint: Use loop for thread_struct->ptrace_bps
        https://git.kernel.org/powerpc/c/6b424efa119d5ea06b15ff240dddc3b4b9f9cdfb
[11/16] powerpc/watchpoint: Introduce is_ptrace_bp() function
        https://git.kernel.org/powerpc/c/c9e82aeb197df2d93b1b4234bc0c80943fa594e8
[12/16] powerpc/watchpoint: Use builtin ALIGN*() macros
        https://git.kernel.org/powerpc/c/e68ef121c1f4c38edf87a3354661ceb99d522729
[13/16] powerpc/watchpoint: Prepare handler to handle more than one watchpoint
        https://git.kernel.org/powerpc/c/74c6881019b7d56c327fffc268d97adb5eb1b4f9
[14/16] powerpc/watchpoint: Don't allow concurrent perf and ptrace events
        https://git.kernel.org/powerpc/c/29da4f91c0c1fbda12b8a31be0d564930208c92e
[15/16] powerpc/watchpoint/xmon: Don't allow breakpoint overwriting
        https://git.kernel.org/powerpc/c/514db915e7b33e7eaf8e40192b93380f79b319b5
[16/16] powerpc/watchpoint/xmon: Support 2nd DAWR
        https://git.kernel.org/powerpc/c/30df74d67d48949da87e3a5b57c381763e8fd526

cheers
