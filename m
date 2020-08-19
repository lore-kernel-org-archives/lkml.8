Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA78C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF96920882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHSJFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgHSJE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:04:59 -0400
Received: from mxout014.mail.hostpoint.ch (mxout014.mail.hostpoint.ch [IPv6:2a00:d70:0:e::314])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4646C061757;
        Wed, 19 Aug 2020 02:04:58 -0700 (PDT)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k8K1b-000NWz-49; Wed, 19 Aug 2020 11:04:51 +0200
Received: from [2a02:168:6182:1:2c96:ee1d:6a9a:1f33]
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1k8K1b-000IMW-1R; Wed, 19 Aug 2020 11:04:51 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
Subject: Re: [PATCH] ARM: at91: Add GARDENA smart Gateway AT91SAM board
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Stefan Roese <sr@denx.de>,
        Michael Zimmermann <michael.zimmermann@grandcentrix.net>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200810171921.8679-1-code@reto-schneider.ch>
 <20200817102136.GC4500@piout.net>
From:   Reto Schneider <code@reto-schneider.ch>
Autocrypt: addr=code@reto-schneider.ch; prefer-encrypt=mutual; keydata=
 mDMEXsRRExYJKwYBBAHaRw8BAQdAvw3GH8aeA8Pay1QqPdjlETAUDAa8WmHHXZRDk5a0DHa0
 J1JldG8gU2NobmVpZGVyIDxtYWlsQHJldG8tc2NobmVpZGVyLmNoPoiYBBMWCgBAFiEEP2/t
 baSDn9KAkTQyv7k+j0IlhuAFAl7EURMCGwMFCQWjmoAICwkNCAwHCwoFFQoJCAsEFgMCAQIe
 AQIXgAAKCRC/uT6PQiWG4IsVAP9xonMRrcrTBWFxPMjEYVWUMHi8BssqkzMdc1QQXwpCKwEA
 qdBF1odOUr4SUHVQmadIE5eRpF9MbyBMQdR3ms8DrQ64OARexFETEgorBgEEAZdVAQUBAQdA
 6PW5+rUjfrKbl3623SR35Drobzij2XjkGFY6zswMz3EDAQgHiH4EGBYKACYWIQQ/b+1tpIOf
 0oCRNDK/uT6PQiWG4AUCXsRREwIbDAUJBaOagAAKCRC/uT6PQiWG4IyHAQCqmjwBTGyVAfLZ
 OVQSUPqSlu/RGcCWPQFEXP+Be2mdNQEA05ScK4+GgAShVE8wUObbpjdl/u5djZF8hEGQR3Ke Vws=
Message-ID: <02431938-63ac-7f90-d985-534bcd60aac2@reto-schneider.ch>
Date:   Wed, 19 Aug 2020 11:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817102136.GC4500@piout.net>
Content-Type: multipart/mixed;
 boundary="------------B39DB9DE1623DCE625606089"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B39DB9DE1623DCE625606089
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Alexandre,

On 8/17/20 12:21 PM, Alexandre Belloni wrote:
> Thank you for this submission.

Thanks a lot for the feedback.

I will send a v2.

> Overall, I'm not convinced it is a good idea to start from
> at91sam9x5ek.dtsi as it makes you dtb bigger than necessary but if you
> want it that way, I'm fine with that.

Because using at91sam9x5ek.dtsi saves some code (maintenance effort?!) I
am willing to accept the extra binary size.
However, if you think that this causes the maintenance efforts to be
greater than when doing it your way, I'd be up for changing it.

Kind regards,
Reto

--------------B39DB9DE1623DCE625606089
Content-Type: application/pgp-keys;
 name="0xBFB93E8F422586E0.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0xBFB93E8F422586E0.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
XpxTgY94Its7BZwpBw==
=1Ttn
-----END PGP PUBLIC KEY BLOCK-----

--------------B39DB9DE1623DCE625606089--
