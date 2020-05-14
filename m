Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA5EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF949206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589449121;
	bh=p1doL36G2c7yhzTcmyQM52QYqsuvRFETy5dpSj2TRJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=1IRKN03Uypp0uuStYVyolEJyA8DXzUbF/RWlA7mjU47TJk6uvEz74r9tsJar9xOoJ
	 mzy4yZZ12NFb+gZbTIF1ECuFHKiTpSS8jj9z2MIreZjZL7an/oL/sIPvZlAa4jnveL
	 fRKGVBumaqaqRTO1rH76NF+GgVw/Unx/JzE3aIYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgENJil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:38:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0953C061A0C;
        Thu, 14 May 2020 02:38:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z22so2084831lfd.0;
        Thu, 14 May 2020 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=p1doL36G2c7yhzTcmyQM52QYqsuvRFETy5dpSj2TRJ0=;
        b=toI+rQpJnNbUCzcB+dgkiFl8ZbxTzcp06t53gOCpWvhpI+lmGb+KFHlEvaufI6/A/l
         zHVf/rngtHD8UvZsZ0BpsW4KmsUyaQClpKSdgm9HLuFPVsSlbEpQZixShCGUwur8dJf0
         uGYG+IepnjneVJ3UySonJ2FYkAHJbkcJAuTXQEoMMbYnGQEOqAYUc65rm5nHUeqg+dcT
         G2g6RuM5CZVJ0+1eU7vrMbBuqoJon/IaAOUbmdJScRcfMuoqiIkMaKHFvDmtwMm/uGRt
         H7dLzRm1URyCs9fW8FiWvwljgZeUL4xHGL8J5aLVvwJVMOVjD64wh2V/TmHW4xEcrSj0
         +PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=p1doL36G2c7yhzTcmyQM52QYqsuvRFETy5dpSj2TRJ0=;
        b=CbzE2O3hHfHVUDUY8Faqzf1N7EqewfEeVBE0rYyHhtXEYUyxvfeSQfUwM/N3YNwCqp
         tVVCPEkZ6dvvZjtGUX26qgCOmRc5lhoA2/RsjF729EeBtGLysJfQ/hDnH6GS+EHyYhLg
         CXbG1sL6Ta4uTbAshf9PKQq2Q0tX3m9GydnUcbIaSqtQLz+r9PPB/4os2hcTbZtZdy97
         2mgPbJ5FN9tXSkgv7dyFhp/M3cs9irM8XBjExKZEsgu06Jy3E5ziZnM6q9u0zi2Rgedy
         hY8Wgo30OZbEwDQybjxjbBFreZqwt7a6FZqzlC8vlLxgrgNxX39IISkC06CpwfWJJSRX
         WsqQ==
X-Gm-Message-State: AOAM530qhf0kdvR+KjRzscCoAA5XopA+XUCZ2q5TMCOGJJrJAbZ1osqz
        EL+oDNuWXDAwzsHojB5CHNS3GouJEwqm/g==
X-Google-Smtp-Source: ABdhPJweyHUB48SIZU9eU3c0UH9UXABozzSP4zy46Gq1mNAcOXb8OYrBNiR8O6eFfLYj5n/NGtVV0A==
X-Received: by 2002:a19:f70f:: with SMTP id z15mr2686757lfe.53.1589449118242;
        Thu, 14 May 2020 02:38:38 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id f25sm1071515lja.5.2020.05.14.02.38.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 02:38:37 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        Stan Lu <stan.lu@mediatek.com>
Subject: Re: [PATCH] usb: gadget: u_serial: fix coverity warning: negative index at array
In-Reply-To: <1589443500-3990-1-git-send-email-macpaul.lin@mediatek.com>
References: <1589443500-3990-1-git-send-email-macpaul.lin@mediatek.com>
Date:   Thu, 14 May 2020 12:38:33 +0300
Message-ID: <87zhaa5012.fsf@kernel.org>
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

Macpaul Lin <macpaul.lin@mediatek.com> writes:

> This issue has been reported by coverity scanner.
> Replace "int portnum" by "unsigned int", this void negative index at
> array.
>
> Signed-off-by: Stan Lu <stan.lu@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

please rebase on testing/fixes

error: patch failed: drivers/usb/gadget/function/u_serial.c:587
error: drivers/usb/gadget/function/u_serial.c: patch does not apply
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
Applying: usb: gadget: u_serial: fix coverity warning: negative index at ar=
ray
Patch failed at 0001 usb: gadget: u_serial: fix coverity warning: negative =
index at array
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl69EZkACgkQzL64meEa
mQa6Qw//Z0NbbILQ3n/09Coti9vMt51E2QalESJ3ogcfVbWjTSptfs2I6x92JE0Y
fIpmObM90gVjqzGmDGgBj3iwZZTVkddXWDasoW2w18o05g2R65TDGBwO1C1XDlaN
DdGn0GLUNcifF5t/rUEy2Csqv35IwKluHmDdsLTjVlTWFdPKkT1VaW0/caI1CpFf
rk4CloEcMxwGBLdx98CPyY24MzzyyhtxNjahZ+hCCXO5S0GF2dnpaaZ1x/TtZ5VN
UbdQzSgrDMEuMtrrUfIlakrTTR6aELxqm0yAqupDsbBAkPdLfpXooqfwKB4fEmhJ
Ns1+CUiAK+BmpXEKmyWybSSUwe+FSBkuUK9+QskFGB/R0mjjyXQVdbYpgL1OIjY1
eBDWzSQZmNGMJ0iLZXc1az0+XVxeI2KKzN+n1IYCwgQTQNYUCYtEEDpFaFEosogt
hmVmo2/iadctVQ/+PU8hfcmylLg6hUBMrApObdsY3JB8tq7SOJIyW2Hx2+Imktwg
vnTnKrFcXLSTmJ/0HbHkP6XZ1UDt1Go06rPzCBzahTPdXVKcqT/D+L7fm7sHmcCX
C/2pHGtodGiUt9R9m+eeYilDbUTTj95vmGzyu/mPtRG5tAOqsSVDVyLffuBFDZe8
Y05awSTgxKqblxXWlK+UZNsvV4nxOTxCaovWn5XoGtA8GYk64Mo=
=XPNg
-----END PGP SIGNATURE-----
--=-=-=--
