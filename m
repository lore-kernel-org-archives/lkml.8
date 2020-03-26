Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC77BC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2A22073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MQPwBnmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCZWms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:42:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40869 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:42:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id w26so8899733edu.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUglTJY60k/VNdcHM8mWBp0Wt/HBwX9IipXPiPlgn8w=;
        b=MQPwBnmAmuVapE8voWiDYLTWURcpWf90RQTJQGxGPu6mY/54TCm27ZFBemawysP2ne
         b4TFic9ZqjeDXKtxb1Vad6mx60Le/sdnGqiAR03fgOdCvWE+8M0mOQfW4lBUWoe4DLYx
         2h/P8RB3ITGLcpzLJpIaCdIxJNl4n0J3o1unJhwsNeVUv7BH+bZBRvekEdVPbhuXjOFF
         YsRYaclcewnZxcNXsoWCmFUNnEkhQAA+kJYgU6JG2IoHy4hwRnGVg/zdOQJH6O2pXuuf
         am58u4bgb3p6yFSQ7NrbOH1JjPbTIOlVKllIHGU22jhZG7jh55ljownJP9WdcMMoZxVo
         /2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUglTJY60k/VNdcHM8mWBp0Wt/HBwX9IipXPiPlgn8w=;
        b=tGOwn+DW3NLnWpxOnNgPASnSsFcqcIq+qwgiUn2aivWE3a88Pj8fPXy6jsC7kocKVu
         HouAECL3HEJZvZ37iqs9L3NsYvS0fNZleD/8cYbpjV/PQO/c2O4uN4EjO67fRBLhk/MR
         Zri+4akV1nEoMvUvsN4ODF3FXHQGdqv/RxSAl4EJ1hYTYwZUtHMfkmGSKrywgLBcQChk
         ZCFCj1RwlWXG++NGqeETP9XnfmM/d8xCaQr0yuRjOUnu8lvxTd7vWUf5YKGk6ZbK6Jm+
         p85wpt2I+7kEWWb45R3NppAULPHPXcJeDH4lmOWW9JVcgkZBr2qr4uZTgiNsk4YMP/Ck
         L1mg==
X-Gm-Message-State: ANhLgQ3I81Zrwb2PTH4pGRYnONVVup2ZHnK2Y2KPOfazQVhyjPVHN6Xy
        X1XwC1J8TcQX9wQ/e9rjuwxS/78WkKxZGMacVU4=
X-Google-Smtp-Source: ADFU+vt9fM5/Lh/iQoYKhQ3WMcsmWRhFmWbiBIl4sQGfSjNJUrYw3Ar9BVh+r+b3CVNqxhzzfDaylTNHvbh2zBIdt7E=
X-Received: by 2002:a50:9e45:: with SMTP id z63mr10548437ede.338.1585262566004;
 Thu, 26 Mar 2020 15:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200326160857.11929-1-narmstrong@baylibre.com>
In-Reply-To: <20200326160857.11929-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 26 Mar 2020 23:42:35 +0100
Message-ID: <CAFBinCCwvfycP9VZ35Jn=yNRbgbUYkRucLPpRGCJv2XCTR+o6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: dts: meson-g12: usb DT fixes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 5:09 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Misc USB DT fixes for G12A.
>
> Neil Armstrong (2):
>   arm64: dts: meson-g12b-ugoos-am6: fix usb vbus-supply
>   arm64: dts: meson-g12-common: fix dwc2 clock names
for both patches:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
