Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F06EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6F720772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgGHNIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:08:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgGHNIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:08:11 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MpD7H-1kgqgQ1ljb-00qmrC for <linux-kernel@vger.kernel.org>; Wed, 08 Jul
 2020 15:08:09 +0200
Received: by mail-qt1-f173.google.com with SMTP id w27so11331965qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:08:09 -0700 (PDT)
X-Gm-Message-State: AOAM533Xnk9dTx8l1rLnefMKM/vmuyo36hndWzhX0S43O3pZ3CWAkvdb
        Jdz1E084zNsKDyu1egvx1Lza7k+ugbHWK+9mL10=
X-Google-Smtp-Source: ABdhPJy+qX37Mgp7IZYqB1zElO4yASFTVrPEo1j75AXuQgQ3GxKiilRQpyT4gOqX6Y8nKCbG/DK1p/wpr+nycHZo7g4=
X-Received: by 2002:ac8:33d7:: with SMTP id d23mr59862578qtb.204.1594213688263;
 Wed, 08 Jul 2020 06:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200708125711.3443569-1-lee.jones@linaro.org>
In-Reply-To: <20200708125711.3443569-1-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jul 2020 15:07:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1-jhevLPR4=0ddg198yn8Ogwb+W2BJ2Ozqg1Yb8ZYiAg@mail.gmail.com>
Message-ID: <CAK8P3a1-jhevLPR4=0ddg198yn8Ogwb+W2BJ2Ozqg1Yb8ZYiAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Mop-up last remaining patches for Misc
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VSgYG3PHPRZT01/FwzUbts9UikTIX0jk23g1RGefWcBZXE1jMYT
 evvL+MJl2NzvGvCTryeJFl8TnxfQ8vPJHTQ4N51TynYF7TRipPt/2aXJmO/kJaK0bMc5Dlp
 PHClU3rc8f20xHz0cp8kxm2VyV9MCGVelm9yFzf9XTqFxgNiMZ5iM9RTjOAjZH290/9PiA/
 xWMYZa3KVkIs7iiXIF6KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cg1DeH4yOAg=:0YlwPf0iymMxFi5eMctziD
 jOFPu02t7qymIj/XdzLhwyisA/dQF1sVavzWuxlRfEQMPRFrjNcsAKeGfKk7RsQaXJtttHYvU
 XNq5aZD+bvA5Tr6jg8nuLyGmyokY6kjDhRgkVAunqKd8wwixagv3WGY7zMAn6yO2eYt1wPmJd
 7LNgXVdfXZz+FO3CSQw3Pm8DS9fCmFukw3nzEu7vhTjfVPdoLyHjGrkbQ1U5aUGnB2jvkHLVC
 GlKbZstx516lpenDzH01KwwTmHRD23sBXVp1kCrgN0NoF0rRNErPrzNQqK0z+36pN3M3Db2VI
 dIm/Y2WGUxnaMENg5Kg/RE4d0cUUqW1q9A0EAmEHWfRzJ/QXrEep3ov7X96ARzisub9pTpQhm
 3t77EMBfvcnPzZoHJblSX4y0GL5EmB66y0yM6PY9P6cfccQbCelvZp0VIIXelBNR4ixEfsDF+
 OSTtKmRXCfSJUkLxRoLSDXGTO/Wk+hdk9EYUyTlbdEGwwNVofcBnAyd3f09BRSUFMmVb1iqFu
 ppDEN1p7/Qzwu315QIBsxE53Y2Vw4WOEIe/ItKvXHDWOEVIBer9Gp1Pyt7BgQjyg0wrdpm9dr
 Ancv4C7fmmWE1ALjb+DbxmiUNSxONDcWoM4lAuoxZgCJxzvq+k5vyNomdsU3cLJxXjJn9Qg1d
 x9A1VfUNwgYm+85mFOJdCY/Y4lAIHaWsVnUsGJsLtQk/cRoCCdPcov8cB/tWneR6/+VG87KvE
 lkx6bn9/l8DVYmr13TZc/e7tioL1Ly/V4P59hid24n/KjTT8C2qtgibw4fJUAJIgkZjzzbc/n
 q+ah8tzikj8KjtpPUJOwqDXAeaPRErWkWVvSh8laUZutSHS7DRARwE/U4G9Zk79Dqrb2X8x
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 2:57 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> These required fix-ups or were waiting on review.
>
> Lee Jones (3):
>   misc: vmw_vmci_defs: Mark 'struct vmci_handle VMCI_ANON_SRC_HANDLE' as
>     __maybe_unused
>   misc: eeprom: at24: Tell the compiler that ACPI functions may not be
>     used
>   misc: cxl: flash: Remove unused variable 'drc_index'

All three

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the cleanup!
