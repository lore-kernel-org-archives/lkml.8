Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88069C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A0B2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD7IEbsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgCXWaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:30:00 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34504 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgCXWaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:30:00 -0400
Received: by mail-pj1-f68.google.com with SMTP id q16so1631848pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x05q+wZ49/Pk/12UuvPipPbvrgDmK5ko/9El70Dqc1M=;
        b=eD7IEbsqdA0EdD/6H0QwiA/EGsrPJQdYtlFQOYWrSXBeyMN9bdTuHuyh78rgG+fjJD
         RKHRKGzqUKPoVTAif9N3I9MkyPKkLfXwYHfzMim9KbX49SAKChtq9cA02yLbhhJVMswK
         C+XVNeiczmeyWyLeUcXOgujZLRCrOOr8aanHD7I/LIr6onAKDYUaZRtQcxR0bavT+YWF
         XERP/n/kscfA1xMEQSJAxB6s9qxNL7rDfCleVkgBpXTEtjApSHAjPTn3NsQ82Qbvr9se
         8MOIqcSd6XW5bv83I5CIFkYtg3GAMKP7Dd4qIIklG7oiA08EqbBv72t1lHlKJMtuUFi6
         f84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=x05q+wZ49/Pk/12UuvPipPbvrgDmK5ko/9El70Dqc1M=;
        b=JFykygR2U8dhSfRB61ibLunKTwJyl4ZnVXwXCBJUUGt7XURKYnU946Jj8wUur3i8po
         6FTTlHS+YkJvRdDUdzfnvM11UPRso7xaFvS9WMQCwM26AiFOkHPRz9q8UDxp/VEtzg+p
         wh9HmtwkfmJC408ln6TeA8sApcMjCnJehajjEDX4I9jbzuKwTwZwqM4DFJLD4hD4Bi0f
         Jug4rRssnq/UbbX3p+pwpmcAxPgRhwRtUltOy2W+y8xUGWXZ2cSJOyhlVZDazJYX531W
         ZQBJfjTwdQ/ktXOVNfU6gncBvlZmaDnBMaYYLVPu23fGfRekGK6s7UKUHOcmmtmGHc91
         IsXQ==
X-Gm-Message-State: ANhLgQ0bfFggiuGhQgCf9aiwu0Ww7NS2bbJ58P95H7+E7dyTwGy59WT4
        zIc5G08dyHq4rcALfJ9Q0/g=
X-Google-Smtp-Source: ADFU+vtt1BEGsdHYbjJjJk3uLa12ICwoXGAunw/Rg1kDwGKfpOgAvQ3Tj2ZqDRVSYJ09FKBu2mN/OQ==
X-Received: by 2002:a17:902:7886:: with SMTP id q6mr216928pll.237.1585088999126;
        Tue, 24 Mar 2020 15:29:59 -0700 (PDT)
Received: from Gentoo ([103.231.90.172])
        by smtp.gmail.com with ESMTPSA id m13sm3101250pjq.26.2020.03.24.15.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 15:29:58 -0700 (PDT)
Date:   Wed, 25 Mar 2020 03:59:46 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux@leemhuis.info, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rearrange the output text, cosmetic changes
Message-ID: <20200324222943.GA18504@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Perches <joe@perches.com>, linux@leemhuis.info,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
References: <20200324084513.18237-1-unixbhaskar@gmail.com>
 <fb5a17c67f504f5761069ee446cc1b703dd8b54f.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <fb5a17c67f504f5761069ee446cc1b703dd8b54f.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08:15 Tue 24 Mar 2020, Joe Perches wrote:
>On Tue, 2020-03-24 at 14:15 +0530, Bhaskar Chowdhury wrote:
>> As the subject like says, purely cosmetic changes to read cleanly.
>> Jumbled up the line.
>
>Subject line should show tools or kernel-chktaint
>
>and:
>
>> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-ch=
ktaint
>[]
>> @@ -195,8 +195,9 @@ else
>>  	echo " * kernel was built with the struct randomization plugin (#17)"
>>  fi
>>=20
>> -echo "For a more detailed explanation of the various taint flags see"
>> -echo " Documentation/admin-guide/tainted-kernels.rst in the the Linux k=
ernel sources"
>> -echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernel=
s.html"
>>  echo "Raw taint value as int/string: $taint/'$out'"
>> +echo
>> +echo "For a more detailed explanation of the various taint flags see be=
low pointers:"
>> +echo "1) Documentation/admin-guide/tainted-kernels.rst in  the Linux ke=
rnel sources"
>
>One extra space between "in  the"
>
>

Thanks, Joe ...fixing! next patch should have fixed them.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl56idQACgkQsjqdtxFL
KRU+FQgA0vWZXAC46/cFThHhqi3APYLNXvP1Za3YAOM6bPABw4++toTOsXlD+Bf0
ezijTIc6cqeU8nQaiyQRjh4k3JQ0p6PAL53+Syqip4su+y3CoTSKg23o4r6S/hGi
79zwSZWu0MZxIskiL25P+66QUOMM/AiLMNkibU7+MtPPEtB5xNVLmt/vepmXAtyy
NQ9H9pP7I31d08Zjs3dwXuqo/rl36EEagQ1YfQ0LE34PqVR+PlVv5GE9t+ZSDwWH
pYDcLwobvsfuMM60skTqS3w0GVxwctuSUjRtcg0UBnyqrLVUeLn+YZn8voYyvZWZ
lV1YZ0oqOyfbVVEglxsnxslukJhj7Q==
=aKGe
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
