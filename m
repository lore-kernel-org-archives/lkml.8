Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF9C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5252469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgB0QiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:38:24 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38988 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730046AbgB0QiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:38:23 -0500
Received: (qmail 3423 invoked by uid 2102); 27 Feb 2020 11:38:23 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2020 11:38:23 -0500
Date:   Thu, 27 Feb 2020 11:38:23 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Boqun Feng <boqun.feng@gmail.com>
cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-arch@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] Documentation/locking/atomic: Add a litmus test
 smp_mb__after_atomic()
In-Reply-To: <20200227004049.6853-6-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002271138080.1730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, Boqun Feng wrote:

> We already use a litmus test in atomic_t.txt to describe atomic RMW +
> smp_mb__after_atomic() is stronger than acquire (both the read and the
> write parts are ordered). So make it a litmus test in atomic-tests
> directory, so that people can access the litmus easily.
> 
> Additionally, change the processor numbers "P1, P2" to "P0, P1" in
> atomic_t.txt for the consistency with the processor numbers in the
> litmus test, which herd can handle.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>


>  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
>  Documentation/atomic-tests/README             |  5 +++
>  Documentation/atomic_t.txt                    | 10 +++---
>  3 files changed, 42 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> 
> diff --git a/Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus b/Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> new file mode 100644
> index 000000000000..9a8e31a44b28
> --- /dev/null
> +++ b/Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> @@ -0,0 +1,32 @@
> +C Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
> +
> +(*
> + * Result: Never
> + *
> + * Test that an atomic RMW followed by a smp_mb__after_atomic() is
> + * stronger than a normal acquire: both the read and write parts of
> + * the RMW are ordered before the subsequential memory accesses.
> + *)
> +
> +{
> +}
> +
> +P0(int *x, atomic_t *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*x);
> +	smp_rmb();
> +	r1 = atomic_read(y);
> +}
> +
> +P1(int *x, atomic_t *y)
> +{
> +	atomic_inc(y);
> +	smp_mb__after_atomic();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists
> +(0:r0=1 /\ 0:r1=0)
> diff --git a/Documentation/atomic-tests/README b/Documentation/atomic-tests/README
> index a1b72410b539..714cf93816ea 100644
> --- a/Documentation/atomic-tests/README
> +++ b/Documentation/atomic-tests/README
> @@ -7,5 +7,10 @@ tools/memory-model/README.
>  LITMUS TESTS
>  ============
>  
> +Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
> +	Test that an atomic RMW followed by a smp_mb__after_atomic() is
> +	stronger than a normal acquire: both the read and write parts of
> +	the RMW are ordered before the subsequential memory accesses.
> +
>  Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  	Test that atomic_set() cannot break the atomicity of atomic RMWs.
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index 67d1d99f8589..0f1fdedf36bb 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -233,19 +233,19 @@ as well. Similarly, something like:
>  is an ACQUIRE pattern (though very much not typical), but again the barrier is
>  strictly stronger than ACQUIRE. As illustrated:
>  
> -  C strong-acquire
> +  C Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
>  
>    {
>    }
>  
> -  P1(int *x, atomic_t *y)
> +  P0(int *x, atomic_t *y)
>    {
>      r0 = READ_ONCE(*x);
>      smp_rmb();
>      r1 = atomic_read(y);
>    }
>  
> -  P2(int *x, atomic_t *y)
> +  P1(int *x, atomic_t *y)
>    {
>      atomic_inc(y);
>      smp_mb__after_atomic();
> @@ -253,14 +253,14 @@ strictly stronger than ACQUIRE. As illustrated:
>    }
>  
>    exists
> -  (r0=1 /\ r1=0)
> +  (0:r0=1 /\ 0:r1=0)
>  
>  This should not happen; but a hypothetical atomic_inc_acquire() --
>  (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
>  because it would not order the W part of the RMW against the following
>  WRITE_ONCE.  Thus:
>  
> -  P1			P2
> +  P0			P1
>  
>  			t = LL.acq *y (0)
>  			t++;
> 

