Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEEFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B700520801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLQRD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:17:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:42211 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgFLQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:17:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-275-Rg5Ewbm4N1GXENH-TTDXpQ-1; Fri, 12 Jun 2020 17:16:58 +0100
X-MC-Unique: Rg5Ewbm4N1GXENH-TTDXpQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 12 Jun 2020 17:16:56 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 12 Jun 2020 17:16:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Xiaoming Ni' <nixiaoming@huawei.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>
CC:     "alex.huangjianhui@huawei.com" <alex.huangjianhui@huawei.com>,
        "dylix.dailei@huawei.com" <dylix.dailei@huawei.com>,
        "chenzefeng2@huawei.com" <chenzefeng2@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC] cred: Add WARN to detect wrong use of get/put_cred
Thread-Topic: [PATCH RFC] cred: Add WARN to detect wrong use of get/put_cred
Thread-Index: AQHWQKQ4FhLI5egRjUmWWYYpyV8csKjVJp0w
Date:   Fri, 12 Jun 2020 16:16:56 +0000
Message-ID: <9a680489a44b44d397f8a3e77a6503e7@AcuMS.aculab.com>
References: <1591957695-118312-1-git-send-email-nixiaoming@huawei.com>
In-Reply-To: <1591957695-118312-1-git-send-email-nixiaoming@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoming Ni
> Sent: 12 June 2020 11:28
> Cred release and usage check code flow:
> 	1. put_cred()
> 		if (atomic_dec_and_test(&(cred)->usage))
> 			__put_cred(cred);
> 
> 	2. __put_cred()
> 		BUG_ON(atomic_read(&cred->usage) != 0);
> 		call_rcu(&cred->rcu, put_cred_rcu);
> 
> 	3. put_cred_rcu()
> 		if (atomic_read(&cred->usage) != 0)
> 			panic("CRED: put_cred_rcu() sees %p with usage %d\n",
> 			       cred, atomic_read(&cred->usage));
> 		kmem_cache_free(cred_jar, cred);
> 
> If panic is triggered on put_cred_rcu(), there are two possibilities
> 	1. Call get_cred() after __put_cred(), usage > 0
> 	2. Call put_cred() after __put_cred(), usage < 0
> Since put_cred_rcu is an asynchronous behavior, it is no longer the first
> scene when panic, there is no information about the murderer in the panic
> call stack...
> 
> So, add WARN() in get_cred()/put_cred(), and pray to catch the murderer
> at the first scene.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  include/linux/cred.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 18639c0..c00d5a1 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -224,11 +224,16 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
>   *
>   * Get a reference on the specified set of new credentials.  The caller must
>   * release the reference.
> + *
> + * Initialize usage to 1 during cred resource allocation,
> + * so when calling get_cred, usage cannot be 0.
>   */
>  static inline struct cred *get_new_cred(struct cred *cred)
>  {
> -	atomic_inc(&cred->usage);
> -	return cred;
> +	if (atomic_inc_not_zero(&cred->usage))
> +		return cred;
> +	WARN(1, "get_new_cred after __put_cred");
> +	return NULL;
>  }
> 
>  /**
> @@ -280,11 +285,14 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
>  static inline void put_cred(const struct cred *_cred)
>  {
>  	struct cred *cred = (struct cred *) _cred;
> +	int usage;
> 
>  	if (cred) {
>  		validate_creds(cred);
> -		if (atomic_dec_and_test(&(cred)->usage))
> +		usage = atomic_dec_return(&(cred)->usage);
> +		if (usage == 0)
>  			__put_cred(cred);
> +		WARN(usage < 0, "put_cred after __put_cred");
>  	}
>  }

You really don't want to add WARN() to static inline functions.
It will bloat horribly.
It might be possible to the message into a called function.

One thing I've thought about for reference counts is for the
code that allocates and frees the item to add a big number
and code that only borrows a reference just adds 1.
If the counter is large enough you can separately detect
double frees and missing frees for the two different types
of allocation.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

