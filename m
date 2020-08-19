Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADAAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD782083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR1k0y6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHSQP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHSQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:15:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA112C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:15:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e4so1342851pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=CkoBycTdFJbVwVUZgNhAFw6X5ZkP+re1+Sfuv+Eawwk=;
        b=IR1k0y6byO8sngJ5HRjTb7yA/92hiW+wczvFdz60zvKus6pflamZQhZoELyeB2E0rp
         WV7ITyBUR7kDAquJuuG5ACFuB6JN9WjsFq/LhydkQGjdiGwZusMKs6MAsw/jUti9Wyst
         43FDYb3n4+L94faUt0/hxG6W3I2MfX3mfEsvcHEWDVnoYMNZSnEitz15yXFg9n0+4yao
         x6YEn+eJUy7MINMeW0e0mjwwaazTN3BpmAOmL/oTVEGrlr84G8Rbst8/92Sz6aX8dGTV
         aaLM6LZV7ED/QcZL3sCfw3hJUE0aJkS+SlM5QENI1y3WUHRs3YPAQAdQkEsBPBVgJ1SX
         vK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=CkoBycTdFJbVwVUZgNhAFw6X5ZkP+re1+Sfuv+Eawwk=;
        b=QDoKhfq+qXyeCXbT36oa7VZ2kyjtgicIOMz9zUUOIjEhU0uzG1BoUeNFQNxzF5qISX
         5QwMtxtCtLuasvp4O6MELRPeKjp7ShpbYlyJAQM7CuaWQoRf4VVqC1ew4ctfPunL9JqA
         WMTeiUDi6s6CvmY8qX7qcj7Sc0qE+cub8HTsVlIE3QWfD7+788/kZ04jhwrJ2D5YAkQ8
         lDE2Sh27lDOshbu9jYWbrS5pjWfvRZG6jONMwdnqdtTDs6SiUNAXIloXv6VCzamJB3QJ
         dptJI+b5mRFY4EbWBS6oXiONQP529BKfj5DhNcOCEpYQNjfFRl8iVGHxTKn1SAFrUl0e
         dThg==
X-Gm-Message-State: AOAM533xXmYbbvGBjqK6iE+XN06HIYUDFh/JzWGWl+p4ZkGd/FYRGhA6
        /3qR5SYw4Jj6hJouqzX8zrs=
X-Google-Smtp-Source: ABdhPJwpeUA6Cp36nPXL7rQZvCFaOCN3XRyAo3IGSkECFfOZhwpEFWhs0Rq5XOpBbMx/d7gfv12VTA==
X-Received: by 2002:a17:902:7d85:: with SMTP id a5mr19403438plm.148.1597853717375;
        Wed, 19 Aug 2020 09:15:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l24sm26264045pff.20.2020.08.19.09.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 09:15:16 -0700 (PDT)
Subject: Re: [PATCH] Revert "seqlock: lockdep assert non-preemptibility on
 seqcount_t write"
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mark Starovoytov <mstarovoitov@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
References: <20200810085954.GA1591892@kroah.com>
 <20200810095428.2602276-1-a.darwish@linutronix.de>
 <20200810100502.GA2406768@kroah.com>
 <bcf94ea2-05e6-2212-f732-b9a79a142f7e@roeck-us.net>
 <169454.1597791078@turing-police>
 <fa442483-00b5-169e-dac2-71fbf8307117@roeck-us.net>
 <20200819070022.semyxepadnvtmtcr@linutronix.de>
 <15863.1597822443@turing-police>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a873e584-ddf3-dacd-4901-514bd961841e@roeck-us.net>
Date:   Wed, 19 Aug 2020 09:15:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <15863.1597822443@turing-police>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R5ny2Hr4xMT4iUvdJepl6mR3v8KtgAsh0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R5ny2Hr4xMT4iUvdJepl6mR3v8KtgAsh0
Content-Type: multipart/mixed; boundary="7etqfthk5t6j4xxTmavMJ9ZLowvlkYtBL"

--7etqfthk5t6j4xxTmavMJ9ZLowvlkYtBL
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/19/20 12:34 AM, Valdis Kl=C4=93tnieks wrote:
> On Wed, 19 Aug 2020 09:00:22 +0200, Sebastian Andrzej Siewior said:
>> On 2020-08-18 17:56:49 [-0700], Guenter Roeck wrote:
>>> Nice catch. FWIW, there is no obvious reason why this would need to b=
e atomic.
>>> The calling code does not set a lock, meaning there can be two (or mo=
re)
>>> callers entering this code. Weird, especially since the code looks li=
ke it
>>> would actually need a mutex to work correctly. It might be interestin=
g to
>>> see what happens if there are, say, half a dozen scripts/processes tr=
ying
>>> to read the hwmon attribute introduced by this patch at the same time=
=2E
>>
>> =3D> https://lkml.kernel.org/r/20200818161439.3dkf6jzp3vuwmvvh@linutro=
nix.de
>=20
> Looks reasonable to me, though I've not verified that it's preemptible =
at that
> point...
>=20

hw_atl_b0_get_mac_temp is called through the .hw_get_mac_temp callback.
This callback is executed from aq_hwmon_read(), which in turn is called
from the hwmon core, more specifically from hwmon_attr_show().
Calls from the hwmon core are unlocked.

Guenter


--7etqfthk5t6j4xxTmavMJ9ZLowvlkYtBL--

--R5ny2Hr4xMT4iUvdJepl6mR3v8KtgAsh0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEiHPvMQj9QTOCiqgVyx8mb86fmYEFAl89UBIACgkQyx8mb86f
mYE2Zw/+O8qwhmPTiHgUk7kSzCLZYUD2ff80lIaKw0Kqb+03oWbn85Lt3C81Db5i
sugtFHPq1KOKJBXFITCE1AXjjr2p2M5ZvRKA2u867zKORkcu+fo5b7Dw4fZ6exmh
d/dqm+7+y1+2Bn5Wep0B5ZhDQIBc7341Xbr6jtcD6hg3eqcnST99IsJduTZpVl7Y
SfWPq+EUJyRfThw27pqKN2x9DL4y4vYET8plcPSEKJP/IJIlRanO+cNNYYC6mHny
5nPUC9E5pzcn3LNzipAD+CFFmi3vlk6EymrypbMCBCqTzIsgnbEYvARTFm1sy03k
Qiaj2k2R2oz4zU16DkJCKoADss+MhLeMrechbcr1E7EgPz2GmT8KyXd4rNz8S8VY
pK2+BD21POe07ZjAXA0iv5m8onL1BDfLmtpek5bB3B3JcsHSdiEAAziECCujxNcz
CkKImTM9EGtDNHkcN1QDY94PO7GoA9NvvS1KKB2KVas2kbEXPBcbnGaiH6/9BXO7
3tztFENx3fME+rqM/O8aXD0W742sO7lifT3wQ9kkxj9YFmaKpEhsK1QRS63u6RWQ
78k4cgpi3DbClb3C7BQPVqwSZAbVFRnsX0cSu/voWjukWrVSUHwXel5dZdbGhzyF
GVjc9rCcst26vXxDISEhKSWuSnfIvI4lDakJseP4jxpcfyXczYc=
=iJtF
-----END PGP SIGNATURE-----

--R5ny2Hr4xMT4iUvdJepl6mR3v8KtgAsh0--
