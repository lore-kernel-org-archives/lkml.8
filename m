Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8277C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB19206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589451799;
	bh=kPLgAoeDvjqvMiUbbtOCGt9Dlqa9nnBcxI4ynwYqCpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=mlpIgg/kgPhARKn3KNk8kA7KTUMjS7HNVdE8pvt6NSxHIGq9T8Wce6PgLk/ZGVpMp
	 vQateK733qQTDs2vrQK8XwVtfpjmV6IHuXDc2VcjxCgNOTUOb52cbniKqMSG6pYeXe
	 GT07kSs+wC1C5g/j0ZHcZuhUMJZFPth3fA6E4w4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgENKXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgENKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:23:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E47FC061A0C;
        Thu, 14 May 2020 03:23:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d22so2131667lfm.11;
        Thu, 14 May 2020 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=on2D6elu53pZj4wNtYf7fZ0iGgEMC4vnCrij0e0GY3Y=;
        b=YWwJnh346DomNcO4odW5tj0MMLVzr9cRxcJo6n+Dt9fuMb4qneEfKEKUJHDnEy4yuN
         9cqWkmlSN93BhIYrTXcpa3kA/EtXoX8ZUxllaYJG2VuYBBbRA9Sab18ErkYrm5p02GXG
         KuTLvxrKQOAgsQJ7k3ip3Zz2n2cK/aCqUjj+FRR97mP/BhNETq1YUnciIbbHPU2Fclq6
         P0OJUdtkQMtwoWuV6zDzf6VUTxJlUEXBEwVROI/mQj5BQxuhH/dBkw/PrXszJn+a9ize
         l0mbAGcNZXhgwGywmoULZ8LhWBH+iz0dxAP2/gXPR4N43j6OYq0flMpdSl4iyCvLetSb
         wf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=on2D6elu53pZj4wNtYf7fZ0iGgEMC4vnCrij0e0GY3Y=;
        b=IBpeCbM+Y8eoDYVlEtWfRBFunBTDS42PRdlal6AUBa1o8FyQ5k8J68o0pnJfSlvrR7
         pYFmLq4HeT8l29RVCkP4XZEv+CjtEAfQxs6LNK4zyFCOV8bsDWDcUuMQU/cd2v/2suf2
         NXjhMBDfMj7EsRN11FaP363uvtUjp2ohPI+BpCQa4MOXq+d5301DAYLdwOKmGx4fJfSh
         1A5ZxMcwsja7KgT2AGtaY/CUw09JiuHThCGtDVq9VWchhQRLNljjW8844eCpmKrl10A4
         iffuKA5KtuIcL+1QXMihaoawc6Agxw56lXGesbTqETJs/ZLkxsy+89MkNKjTQuc8iYA1
         298Q==
X-Gm-Message-State: AOAM533pN5Xz/3wSHSY3FpK04TiQRNiSR3ai069XXbEgygBlCvYbQ9wn
        vL+uEPPV/A9Bi2qAEPD5W7DXf5ugdOia5Q==
X-Google-Smtp-Source: ABdhPJz0OX6tX5Djvgz/x/V2SQPdQDpdcaDSPFTtdAjVwURPzcOQ1sZlYNWA8qY/i2cUpwYwILXpBg==
X-Received: by 2002:a19:e041:: with SMTP id g1mr2742299lfj.70.1589451795238;
        Thu, 14 May 2020 03:23:15 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id k9sm1231222lja.52.2020.05.14.03.23.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 03:23:14 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>, kishon@ti.com,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] usb: dwc3: meson: add OTG support for GXL/GXM
In-Reply-To: <87369rfo7l.fsf@kernel.org>
References: <20200324102030.31000-1-narmstrong@baylibre.com> <87369rfo7l.fsf@kernel.org>
Date:   Thu, 14 May 2020 13:23:09 +0300
Message-ID: <87r1vm4xyq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Felipe Balbi <balbi@kernel.org> writes:

> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> The USB support was initialy done with a set of PHYs and dwc3-of-simple
>> because the architecture of the USB complex was not understood correctly
>> at the time (and proper documentation was missing...).
>>
>> But with the G12A family, the USB complex was correctly understood and
>> implemented correctly.
>> But seems the G12A architecture was derived for the GXL USB architecture,
>> with minor differences and looks we can share most of the USB DWC3 glue
>> driver.
>>
>> This patchset refactors and adds callbacks to handle the architecture
>> difference while keeping the main code shared.
>>
>> The main difference is that on GXL/GXM the USB2 PHY control registers
>> are mixed with the PHY registers (we already handle correctly), and
>> the GLUE registers are allmost (99%) the same as G12A.
>>
>> But, the GXL/GXM HW is buggy, here are the quirks :
>> - for the DWC2 controller to reset correctly, the GLUE mux must be switc=
hed
>>   to peripheral when the DWC2 controlle probes. For now it's handled by =
simply
>>   switching to device when probing the subnodes, but it may be not enough
>> - when manually switching from Host to Device when the USB port is not
>>   populated (should not happen with proper Micro-USB/USB-C OTG switch), =
it
>>   makes the DWC3 to crash. The only way to avoid that is to use the Host
>>   Disconnect bit to disconnect the DWC3 controller from the port, but we=
 can't
>>   recover the Host functionnality unless resetting the DWC3 controller.
>>   This bit is set when only manual switch is done, and a warning is prin=
ted
>>   on manual switching.
>>
>> The patches 1-8 should be applied first, then either waiting the next re=
lease
>> or if the usb maintainer can provide us a stable tag, we can use it to m=
erge
>> the DT and bindings.
>
> it's unclear to me if this series is ready to be merged. Can someone
> confirm? If it is, can you resend with all reviewed by tags in place?

Are we getting a v2 for this?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl69HA4ACgkQzL64meEa
mQY4DhAAtHTcNLDu5ri1XuAeABlYEcezvODzuPM7Xg0my7l1TAURKXzAe0LV/LSB
9FU5hFcfAPUD7JSDmyGey9foVoFKo0ZxOvXLTXCW7AFHq5UyphcWAa5dW7kjtrI7
uqJ9VYc6gdQ6a/lEJXTdEuq8lLBt88hJkU8OPjzedp82in9fGXZg0mmwDePj3yVE
6KAnwJG+9qKZ/t06kNY2POoQpyFGnjOruj+9K4kG1R/RXGrU1YV1Cq6+GZp/DNoj
Z81nw30hMBIFmKrxMl9bx+/hXAQUPV0C01txbCkdCGVTtp/L7GB3RXWgEljIyPPw
KiE2yF12BFeuOB2egjAIWVztPxlzh0W19f/2bAQPEhlHrfcu83SJDAdEfMx/pe+w
aFVJhdTZz+GeJ7K1Oame/ddtzbuPTyUbZFo4c0qASictw1dXGir88hOBeRrzpjJ0
d7cmNieizTfV8EoF0/FKN1NuwIie/k/dZiejZ28lukE8pZ2RUXxuBrrncmHk+Hrp
iHTOjXsXTYJgVU4OxXFk9Q+B0YYgvpiAtrAS3Hpn3UQMX+KYd1RMELFSYtBLUGCG
TZ9WJPGijn2G7rmvDy0sJtxhLsRoE9tx7tvr6HG5btz2fMdZmTnK6cW1nyIoP8kP
ijmeyb1OUfQTkFoBIZUIPi5pTkuuqScPtsu7LAF+nP7HjD/+VYk=
=8p6e
-----END PGP SIGNATURE-----
--=-=-=--
