Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B6BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D672075E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi/MFkPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDIJAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:00:07 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:43654 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDIJAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:00:06 -0400
Received: by mail-pf1-f173.google.com with SMTP id l1so1896250pff.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=/cvQS25mk8Hyk/XIrBlx8Zb5+sV4eyZg+Ieq4UBdrFE=;
        b=Qi/MFkPzuqGi2FjdSSCBms6C3bD1sNA2Am5bp6owE65teO/qfgKR2wvc5KxHrNK8W4
         oxtiQw/BRuNWK8YBSjW5qYzKmeoRhPlzRqwY6hsi1pTjeK/ium0afMEvdnRNMIDqNVcc
         UNb0czbWUk6tpww4tWAI+OxU6V+rOEyi2+qcVPsvE8L/Hnzjefh/0sYdmZaP4MhCFj2m
         7DR12jnKjVenOZI1Q5gQqaU22GHiRuhB7HK7A7L1otHE9tArU0dgmOrp0Q9VyyIkFoTt
         qv+0XYvEs73Dc7SW5JhDNw6lDW6LMoXdY6RMdkTLdEWE2/SD/5EPXG5AB8xGYM+gjJmz
         fQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=/cvQS25mk8Hyk/XIrBlx8Zb5+sV4eyZg+Ieq4UBdrFE=;
        b=qgL2OMIQjiiR9/KdmL4gDGgdBuxffi11ips7OxX3XxZWa01Yixwfq5ZEzVP5bnoocB
         pcOFmG4af7i2Pn1hWC2BuHfM2FNN3OXxr5E3Fid5EoF77TFErnXgpLsXCTnvVblBplv+
         XzI2wa7/0b/AgiUpbrL+ErdztywKNjwuC3W/2zLiKgv7bW73HAV9rrLP/ZG7+ooc2xec
         S+H4Gp2dDpyQA+41CNDhQ1Ibn5rYXv4ybyfb1U3pwCSsz40y0R/66hsP5jfY/osxDFo2
         DeEw+5fqkv6fZkO837lUgd73lkR8lSjnye1IvYZs8dmI1JexsIPJbG0YhpdeC+jRaU9r
         2nRw==
X-Gm-Message-State: AGi0PuYCTL4u8w7uAhnDkkBOmRFAnHXvZg7el6jIxjK506tyzVRS1f+Z
        tiqpbDBuQ3hHYhGa7pCpzrYwLJBJZMo=
X-Google-Smtp-Source: APiQypIQo6fJ6dFFVEAx6gWrol0me2k/Qj+s9+gsR2prvYtdqrineVTJWgewD4m6hbbZ39fbV2xD7Q==
X-Received: by 2002:a05:6a00:48:: with SMTP id i8mr12665953pfk.20.1586422805880;
        Thu, 09 Apr 2020 02:00:05 -0700 (PDT)
Received: from Gentoo ([103.231.91.67])
        by smtp.gmail.com with ESMTPSA id nm5sm1608123pjb.40.2020.04.09.02.00.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 02:00:05 -0700 (PDT)
Date:   Thu, 9 Apr 2020 14:29:55 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: linux-next tree of 09/04/2020 build ...compile ..boot , without fuss
Message-ID: <20200409085955.GA3723@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Here is some snippet for your eyes:

2.878671] ext4 filesystem being mounted at /root supports timestamps
until 2038 (0x7fffffff)
[    2.879255] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    2.883230] devtmpfs: mounted
[    2.895168] Freeing unused decrypted memory: 2040K
[    2.966045] Freeing unused kernel image (initmem) memory: 1576K
[    2.966793] Write protecting the kernel read-only data: 26624k
[    2.970669] Freeing unused kernel image (text/rodata gap) memory:
2040K
[    2.972429] Freeing unused kernel image (rodata/data gap) memory:
1148K
[    2.973192] rodata_test: all tests were successful
[    2.973664] Run /sbin/init as init process
[    3.027907] process '/bin/busybox' started with executable stack
[    3.216260] tsc: Refined TSC clocksource calibration: 2194.917 MHz
[    3.216915] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x1fa37107ca2, max_idle_ns: 440795258165 ns
[    3.217484] clocksource: Switched to clocksource tsc
[    3.238966] EXT4-fs (sda): re-mounted. Opts: (null)
[    3.239521] ext4 filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator... [    4.215842] random: dd:
uninitialized urandom read (512 bytes read)
done.
Starting network: [    4.469030] random: crng init done
OK

Welcome to Buildroot
buildroot login: root
# uname -a
Linux buildroot 5.6.0-next-20200409-linux-next-2020-04-09 #1 SMP Thu Apr
9 13:55:11 IST 2020 x86_64 GNU/Linux

~Bhaskar

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl6O4/0ACgkQsjqdtxFL
KRW/Pgf/fQ0Foh5jWAkTkGbQW929797/FvZS9ycZQ/+ehVjO2yKGrIl9D82JYTgl
6Dee6iaHqVx0Ch7BnmmV7C2b72ZuIUbfLtY0v460A9yGX1ISss7PqiCxJZ6e9Iko
jiWpEv24eSCBeWP4n6/ED9kGyazQ9RUxbqkFxv9hfvq9V/VY/CdlT1KI8hJCOL+C
BcEa/fxtn5UR4ZtHIHHnJqnIZK0sbB+Xbkkb1AwU87wlyKyUgK/rpqcq8zNalc+K
6B8XcuPNv42Hxd4HHjfXomUL5l7+cRRnWA5q1MtsrMmR4DrRmHfx1G88nl4GkKYW
HZdU32fVPsrOkFZv6+fum2wRQTQHbA==
=/d4c
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
