Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28CEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810AE20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG2uCC6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMIw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:52:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37001 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:52:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id l20so6862650qtp.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eQXzm8BQRHCgGScNDJ9ph6XbAyK4pO8RWnMrgDPmD5A=;
        b=HG2uCC6q51zGyJ5IUzXGLOF3ZSXH64g9NMXs0rLsC0jGgbgR0f7VIwAB045ukMECqW
         SGSGGqPIflJfNX+F861AXeoIxuMVyDh5udbnmt8E5O2Sn6zzrOSFmiUgvwG4djdzAJ3u
         QMaiBeFzCf08cCyBRVvrIbNTbGKSQrKpiHrQdWvrIZwpmMxYOFGlFNdPt2z5/r9fsFii
         1jR5tJOaLP4tBdMOuFLTi6UbADv/xoegqgtnZeq76UVXUgCrNgY9rIAuTQlgJfW+QMkI
         UmdTtHjCoThqRH5M8xNEkJXo7wmvdu1n1SMZJ7dJ6wJtd0uWuhpzjHw7X16tVrtn0L/1
         kThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eQXzm8BQRHCgGScNDJ9ph6XbAyK4pO8RWnMrgDPmD5A=;
        b=QVxoalC/hqMBAAccCmLKCw9J3f/5PGalAhzxlSMFI5vT2av1VwvLBuNWlJgssE/duo
         /RH4tHLJrRz8ttuKmT2f4P78pvMv+3kTTLR3cLjVJo6MbDuZBR4eS46fwSoltwKwo9wO
         MdyO1niup36aZojbGyz7xr0nI/V5r/gYja73Ji2c5mknDgDX2xvhGBo6nR/biEojjrw7
         o6kngRmoqLbkWcXeUI0RElB++/VXydAb+GUi2VdFU6n/Qgh7VRyVK9I/b8QhT4gEFwJl
         7EK/QZ+/kQcbCDOeZOq40yx/Y8/e8kg1xOJzG8sfYdGHtMISAjtzp0jbTtbn0a3NvZvr
         nhXA==
X-Gm-Message-State: ANhLgQ36gxkMfmjLb0APjeqVX+NJ+ehciI0ufIJnef838TrfLfSPq/HQ
        2l57cK5YsbevOz81uuOKtrM=
X-Google-Smtp-Source: ADFU+vumhJC1NHmKCK2UUae1OllNwvnD5pe3DvZAX6jDnrC6vbnpfIdTI6i0ZIQNoPpClQ/o2jX3Pg==
X-Received: by 2002:ac8:304d:: with SMTP id g13mr11652419qte.221.1584089545219;
        Fri, 13 Mar 2020 01:52:25 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id b7sm10775613qkh.0.2020.03.13.01.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 01:52:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 09F0022632;
        Fri, 13 Mar 2020 04:52:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Mar 2020 04:52:23 -0400
X-ME-Sender: <xms:xklrXmeeXhkaBInRAeJvwdPTGBDNdDWfZINjdPTj5PKPDcymRaZ5kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddviedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghes
    ghhmrghilhdrtghomheqnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvd
    dqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:xklrXqQGeMF3aqEkUEXpG_8VHo8lnHb1-r_HOJyA2c_k9VNxytPOHg>
    <xmx:xklrXsd37JqcPY49_gSXbFL4G358qsg-jQPzbVNh88U597jVvsWVAA>
    <xmx:xklrXrusreGxT7218G8J_MNPJSf0Bsid3gwZtfogJLk67p4dxTpUUA>
    <xmx:x0lrXpV_DngwScMOea9lTi_5Rhpfj41_b_LG4BtVPzvxKe-tQovZbI3Agl4>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52B1F328005A;
        Fri, 13 Mar 2020 04:52:22 -0400 (EDT)
Date:   Fri, 13 Mar 2020 16:52:20 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org, elver@google.com,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        cai@lca.pw
Subject: Re: [PATCH kcsan 17/32] kcsan: Introduce ASSERT_EXCLUSIVE_* macros
Message-ID: <20200313085220.GC105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
 <20200309190420.6100-17-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309190420.6100-17-paulmck@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Mon, Mar 09, 2020 at 12:04:05PM -0700, paulmck@kernel.org wrote:
> From: Marco Elver <elver@google.com>
> 
> Introduces ASSERT_EXCLUSIVE_WRITER and ASSERT_EXCLUSIVE_ACCESS, which
> may be used to assert properties of synchronization logic, where
> violation cannot be detected as a normal data race.
> 
> Examples of the reports that may be generated:
> 
>     ==================================================================
>     BUG: KCSAN: assert: race in test_thread / test_thread
> 
>     write to 0xffffffffab3d1540 of 8 bytes by task 466 on cpu 2:
>      test_thread+0x8d/0x111
>      debugfs_write.cold+0x32/0x44
>      ...
> 
>     assert no writes to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
>      test_thread+0xa3/0x111
>      debugfs_write.cold+0x32/0x44
>      ...
>     ==================================================================
> 
>     ==================================================================
>     BUG: KCSAN: assert: race in test_thread / test_thread
> 
>     assert no accesses to 0xffffffffab3d1540 of 8 bytes by task 465 on cpu 1:
>      test_thread+0xb9/0x111
>      debugfs_write.cold+0x32/0x44
>      ...
> 
>     read to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
>      test_thread+0x77/0x111
>      debugfs_write.cold+0x32/0x44
>      ...
>     ==================================================================
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/kcsan-checks.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> index 5dcadc2..cf69617 100644
> --- a/include/linux/kcsan-checks.h
> +++ b/include/linux/kcsan-checks.h
> @@ -96,4 +96,44 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
>  	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
>  #endif
>  
> +/**
> + * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
> + *
> + * Assert that there are no other threads writing @var; other readers are
> + * allowed. This assertion can be used to specify properties of concurrent code,
> + * where violation cannot be detected as a normal data race.
> + *

I like the idea that we can assert no other writers, however I think
assertions like ASSERT_EXCLUSIVE_WRITER() are a little limited. For
example, if we have the following code:

	preempt_disable();
	do_sth();
	raw_cpu_write(var, 1);
	do_sth_else();
	preempt_enable();

we can add the assert to detect another potential writer like:

	preempt_disable();
	do_sth();
	ASSERT_EXCLUSIVE_WRITER(var);
	raw_cpu_write(var, 1);
	do_sth_else();
	preempt_enable();

, but, if I understand how KCSAN works correctly, it only works if the
another writer happens when the ASSERT_EXCLUSIVE_WRITER(var) is called,
IOW, it can only detect another writer between do_sth() and
raw_cpu_write(). But our intent is to prevent other writers for the
whole preemption-off section. With this assertion introduced, people may
end up with code like:

	preempt_disable();
	ASSERT_EXCLUSIVE_WRITER(var);
	do_sth();
	ASSERT_EXCLUSIVE_WRITER(var);
	raw_cpu_write(var, 1);
	ASSERT_EXCLUSIVE_WRITER(var);
	do_sth_else();
	ASSERT_EXCLUSIVE_WRITER(var);
	preempt_enable();

and that is horrible...

So how about making a pair of annotations
ASSERT_EXCLUSIVE_WRITER_BEGIN() and ASSERT_EXCLUSIVE_WRITER_END(), so
that we can write code like:

	preempt_disable();
	ASSERT_EXCLUSIVE_WRITER_BEGIN(var);
	do_sth();
	raw_cpu_write(var, 1);
	do_sth_else();
	ASSERT_EXCLUSIVE_WRITER_END(var);
	preempt_enable();

ASSERT_EXCLUSIVE_WRITER_BEGIN() could be a rough version of watchpoint
setting up and ASSERT_EXCLUSIVE_WRITER_END() could be watchpoint
removing. So I think it's feasible.

Thoughts?

Regards,
Boqun

> + * For example, if a per-CPU variable is only meant to be written by a single
> + * CPU, but may be read from other CPUs; in this case, reads and writes must be
> + * marked properly, however, if an off-CPU WRITE_ONCE() races with the owning
> + * CPU's WRITE_ONCE(), would not constitute a data race but could be a harmful
> + * race condition. Using this macro allows specifying this property in the code
> + * and catch such bugs.
> + *
> + * @var variable to assert on
> + */
> +#define ASSERT_EXCLUSIVE_WRITER(var)                                           \
> +	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
> +
> +/**
> + * ASSERT_EXCLUSIVE_ACCESS - assert no other threads are accessing @var
> + *
> + * Assert that no other thread is accessing @var (no readers nor writers). This
> + * assertion can be used to specify properties of concurrent code, where
> + * violation cannot be detected as a normal data race.
> + *
> + * For example, in a reference-counting algorithm where exclusive access is
> + * expected after the refcount reaches 0. We can check that this property
> + * actually holds as follows:
> + *
> + *	if (refcount_dec_and_test(&obj->refcnt)) {
> + *		ASSERT_EXCLUSIVE_ACCESS(*obj);
> + *		safely_dispose_of(obj);
> + *	}
> + *
> + * @var variable to assert on
> + */
> +#define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
> +	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
> +
>  #endif /* _LINUX_KCSAN_CHECKS_H */
> -- 
> 2.9.5
> 
