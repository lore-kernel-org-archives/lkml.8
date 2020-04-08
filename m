Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D591C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A1520730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+DeUIzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDHXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:35:06 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:55436 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDHXfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:35:05 -0400
Received: by mail-pj1-f45.google.com with SMTP id a32so493932pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 16:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XeJ1J9xCyvH8LQBJm2rYdiMSc45M4Hy6nZ6GVa+Ez9g=;
        b=r+DeUIzhV6JWLg4O983K1xudxAExCE5clCzvI34S23KKNtpM5lSnjo9dxRCN/5qLHX
         6mRg7uUANQj9t5KPYCCWmyNPoBlqJX3Sue/9l5nrokC0GOZxEx58e3iAr9v05UN4m6ho
         7p/rNal5P7gN8e2mxLQ3evD+1z0vHFA5ZWlWMSr9rZJ59wIONSzMLIVVfDcBUzmsLEzN
         8hmbxAEa64sRVI2fs6WtWd0whLuXDTq1+st3tpN3Y68uH86yxEUcuKzUkJGSCCIRIdQH
         UR5B/+F9OZr0P+AzxDYwh/NTzAW4Ym979fENAcpd/lQ8hWhSqVipo4bhma1lNv3Z0R6t
         xwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XeJ1J9xCyvH8LQBJm2rYdiMSc45M4Hy6nZ6GVa+Ez9g=;
        b=NHgk3ZH+/dmnjYj0F8pEt36J8rRdpNMQMl2z6ThLPZdD3vVyO9ep8+eQHnkTsxdCeP
         HVGTIhNPoPIus4iFtck5jYTU3+ak6yCRsrjeT6/lWum9dFg1x7XZ5i5Ebsp04z9Ay1Gp
         lBndIeuUPdUElew/Zfhug6MtDsGKqhXW+gHjiJ2jcGDUgo6NsvnTfVEC9KbYQDSB2ue8
         3dBZKrrUzKsjeYnYy6aoCZL5gBkjwHEEWUhMXRW5fnPSkYmOIda3RVojEgT3QgxdiSUI
         ap7tULtjS3K30J0I1/MVmfoCTdxbAAPuo1oGL7FRA/Ya/GllX/djsoJum8J+NriSQ/sU
         BpsA==
X-Gm-Message-State: AGi0Pub1Cw9I6KnIbIKp4DyiQfklawRsYwDfCn+Nonkwl7f/fmNWSxxz
        2gt/do/0euvvUSfOE5JUj3f3azxl
X-Google-Smtp-Source: APiQypK0A2HuVObwksN+Cc3cBG6YsjMxNOv6GYDlQvPGi7QT91NdCddZlTW32wq8qnndWSobo8dbqw==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr10022285pls.194.1586388904918;
        Wed, 08 Apr 2020 16:35:04 -0700 (PDT)
Received: from debian ([103.231.91.69])
        by smtp.gmail.com with ESMTPSA id t123sm194773pfd.48.2020.04.08.16.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 16:35:04 -0700 (PDT)
Date:   Thu, 9 Apr 2020 05:04:54 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel build failed ...SPHINX extension error
Message-ID: <20200408233450.GA14923@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LinuxKernel <linux-kernel@vger.kernel.org>
References: <20200408113705.GB1924@ArchLinux>
 <20200408132505.52e595bc@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20200408132505.52e595bc@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:25 Wed 08 Apr 2020, Jonathan Corbet wrote:
>On Wed, 8 Apr 2020 17:07:05 +0530
>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>> Extension error:
>> Could not import extension cdomain (exception: cannot import name
>> 'c_funcptr_sig_re' from 'sphinx.domains.c'
>> (/usr/lib/python3.8/site-packages/sphinx/domains/c.py))
>> Apr 08 16:48:46 enabling CJK for LaTeX builder
>> Apr 08 16:48:46   CC      kernel/power/poweroff.o
>> make[1]: *** [Documentation/Makefile:81: htmldocs] Error 2
>> make: *** [Makefile:1549: htmldocs] Error 2
>> make: *** Waiting for unfinished jobs....
>
>This is weird, to say the least.  But I think the "python3.8" in the
>message above says everything you need to know.  If you're running with
>an unreleased version of Python, it's not entirely surprising that you
>might run into trouble with a complex package.
>
>jon

Thank you Jon...will investigate more and keep your suggestion in mind.

~Bhaskar

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl6OX5YACgkQsjqdtxFL
KRW0Pwf+IWfFUp9eD6RKjxJZpwStURv2ED3zh8U++hDIjyprgq7tKaoNnS2uqPMH
+TbLjVr8s1QLbWHcsHOo8AxsToVaOIlm+NOfdbFlT4i3X8UAdJCdyUYDI0VPTvqW
LSP1GUIY05FqM3MCOy5nAxNY7VWanM/TpvusikkncPjJ9ivLzoeMxJ2gTc8ymABA
2LQakgQVlBiknLRr4jRBezyM9AKIo+WytWOihTFzM0k/Jwr7xna18cHeIeXAZ7/n
ktpdtzYBD7+ajoUh67gRNq0n8YuEmy4s7oIYxmjzJyGimnxpWverxCVztHFHF9aZ
50bu3VhDhe5K83OpaLIB0W0JqqVVkg==
=pZwg
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
