Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39CCC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE362072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="FSzDBPth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBZV27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:28:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42395 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgBZV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:28:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id h8so278615pgs.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/yYMvkaAzxa9G7MWrjOVgH0U3xnCVD4fwTP+LyveXVA=;
        b=FSzDBPth4SJbQ2bOqvl6ck75eoMVddAw7fQ1umBj6qX25gZx6m/EcccuiQv4clT2n1
         oWBcZ36EpgJ+mGYC4ZtTF1ieXDFNwJj5UcfMfclvxXxkTpR+HvzlXdmRKTM81mtQHl+s
         iKdVUtUB4TqyMvMDC6xUc/VSilrStm6AGK5oU5uwzo3k9OD2vBW64VLMyL6gmon42ErC
         yNqIFepPCPtCcShv0vvK48oL99l/h91BNiPFMv1xP4FrkHUhvznXEzgSwOUISzcmL6Je
         t/MDa89G/aPdXTd+GtUxMhrgesayO9zqYqcZNjVa89lHkQgQH0jZD73+ccYDH3sR0vv0
         WrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/yYMvkaAzxa9G7MWrjOVgH0U3xnCVD4fwTP+LyveXVA=;
        b=WY2VlQGYgiQ64UND4CnWsgC/KJv3PPS1GZlO7DW8l04SsvmD1J/MwXw3f0wFbQf38E
         D31lP6tUb9fQ7qtTUohFNUooXDiF7MJsJ3viG8CyxCUXdjIHt6UBuh4PL7qVFXPifoM0
         vUj0GjF7V3tQ+VgvfYLPGN4BzdDuYr4uu+plBa5MtsYgydSx1Go9q+6Xulz+l2uCOSFd
         wDNDbOEJGepjaSrXet4queJDYBMvKGbIxCNt3aBpxc3Xnv1fcz0ckuMial4Hl4/+NWMZ
         7a3c4CvHVz/eRpEis/Erjqm3GdQGX/gqbCJ8vks+S76lEb4vNYP481iwopKIhQGQfVYm
         Oe8g==
X-Gm-Message-State: APjAAAUvxTNY0WUz4pbKeSzmLSQfs1be2Ghl54eo7vS0tVofHmIQOXy6
        vXEd5c7ZyUcpOmKzikgiSv1YDA==
X-Google-Smtp-Source: APXvYqxW9NJUEV1Z8lpXj2KQkNw2276JgHswHysV+hs77XXAj2Do2zuWheKO6fET24LY7qqnJc59kg==
X-Received: by 2002:a62:7bcb:: with SMTP id w194mr690591pfc.216.1582752534462;
        Wed, 26 Feb 2020 13:28:54 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id g18sm4188506pfi.80.2020.02.26.13.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 13:28:53 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8A7FCF47-5CFB-47C5-9097-077EC0CC0A2F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Date:   Wed, 26 Feb 2020 14:28:50 -0700
In-Reply-To: <20200226162954.GC24185@bombadil.infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_8A7FCF47-5CFB-47C5-9097-077EC0CC0A2F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 26, 2020, at 9:29 AM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
>> A new sysctl parameter "dentry-dir-max" is introduced which accepts a
>> value of 0 (default) for no limit or a positive integer 256 and up. Small
>> dentry-dir-max numbers are forbidden to avoid excessive dentry count
>> checking which can impact system performance.
> 
> This is always the wrong approach.  A sysctl is just a way of blaming
> the sysadmin for us not being very good at programming.
> 
> I agree that we need a way to limit the number of negative dentries.
> But that limit needs to be dynamic and depend on how the system is being
> used, not on how some overworked sysadmin has configured it.
> 
> So we need an initial estimate for the number of negative dentries that
> we need for good performance.  Maybe it's 1000.  It doesn't really matter;
> it's going to change dynamically.
> 
> Then we need a metric to let us know whether it needs to be increased.
> Perhaps that's "number of new negative dentries created in the last
> second".  And we need to decide how much to increase it; maybe it's by
> 50% or maybe by 10%.  Perhaps somewhere between 10-100% depending on
> how high the recent rate of negative dentry creation has been.
> 
> We also need a metric to let us know whether it needs to be decreased.
> I'm reluctant to say that memory pressure should be that metric because
> very large systems can let the number of dentries grow in an unbounded
> way.  Perhaps that metric is "number of hits in the negative dentry
> cache in the last ten seconds".  Again, we'll need to decide how much
> to shrink the target number by.

OK, so now instead of a single tunable parameter we need three, because
these numbers are totally made up and nobody knows the right values. :-)
Defaulting the limit to "disabled/no limit" also has the problem that
99.99% of users won't even know this tunable exists, let alone how to
set it correctly, so they will continue to see these problems, and the
code may as well not exist (i.e. pure overhead), while Waiman has a
better idea today of what would be reasonable defaults.

I definitely agree that a single fixed value will be wrong for every
system except the original developer's.  Making the maximum default to
some reasonable fraction of the system size, rather than a fixed value,
is probably best to start.  Something like this as a starting point:

	/* Allow a reasonable minimum number of negative entries,
	 * but proportionately more if the directory/dcache is large.
	 */
	dir_negative_max = max(num_dir_entries / 16, 1024);
        total_negative_max = max(totalram_pages / 32, total_dentries / 8);

(Waiman should decide actual values based on where the problem was hit
previously), and include tunables to change the limits for testing.

Ideally there would also be a dir ioctl that allows fetching the current
positive/negative entry count on a directory (e.g. /usr/bin, /usr/lib64,
/usr/share/man/man*) to see what these values are.  Otherwise there is
no way to determine whether the limits used are any good or not.

Dynamic limits are hard to get right, and incorrect state machines can lead
to wild swings in behaviour due to unexpected feedback.  It isn't clear to
me that adjusting the limit based on the current rate of negative dentry
creation even makes sense.  If there are a lot of negative entries being
created, that is when you'd want to _stop_ allowing more to be added.

We don't have any limit today, so imposing some large-but-still-reasonable
upper limit on negative entries will catch the runaway negative dcache case
that was the original need of this functionality without adding a lot of
complexity that we may not need at all.

> If the number of negative dentries is at or above the target, then
> creating a new negative dentry means evicting an existing negative dentry.
> If the number of negative dentries is lower than the target, then we
> can just create a new one.
> 
> Of course, memory pressure (and shrinking the target number) should
> cause negative dentries to be evicted from the old end of the LRU list.
> But memory pressure shouldn't cause us to change the target number;
> the target number is what we think we need to keep the system running
> smoothly.


Cheers, Andreas






--Apple-Mail=_8A7FCF47-5CFB-47C5-9097-077EC0CC0A2F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5W4xIACgkQcqXauRfM
H+CMthAAk0ZIFuajst1+eMMRuT+zEdXLH5sdL0JaLdoqxTEpwjodFUNdYvQwLKTj
DEhuUP3tYh6WlkWF8NtJTE41exOsoguJoNuYCKdzY/pnpNqFz6flxksafBOsBPOj
n0haUxFe8s/bLHnYM388J8N8Rrkk6KWZAw8+nWuEOVo2Phw6z+lAggQoxgrzLkGK
CPipk8hcuSQTosZ+ulIc9kHj6ivyzAtYK2nida8gpFjZ9LFo91zQWmcIjtFZHXMi
tYQctiCySf2e4ienIeFyfTpCf52vyowT7YYqz10mgTsL3r6iKamFefBFbPmHRkNz
EC1e28Xt/VJ7fVzjtHIuid9ZDOS8nLpHOD3n9sE8oOyRC7VXLwrtvWB30tyLT2wf
SQN/LrS/TwTrsrVFNV2YrbUEmlgtKLlM2CLrtzxbrfCxpK2ldqpBn7zLA9nhJoPu
hHFynkbudJUMXRNP1G3XWbhKCGjbYid/8GUVbcKk0b22rlIpEVoxzWxaVZ3aR50V
UKdCmKd9meDe+bL+/HCbPnuiHsc6XRHswMRNmZwkRDdMQ3341h5M9pFeg3YIrZA1
nRTuc6spOWN/4dwB6n/4K0TGUiElYqkr49tLD5/qO+RT2f/a/ljv805UwYXIkq0u
IzKywoiNW94fHVgBdDVDiFGmObYQY/kueeNYI8tP0J8FRpLIrvc=
=hqk8
-----END PGP SIGNATURE-----

--Apple-Mail=_8A7FCF47-5CFB-47C5-9097-077EC0CC0A2F--
