Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF703C54FCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97407208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ofThQBp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgCXOYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43253 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgCXOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id bd14so7019956edb.10;
        Tue, 24 Mar 2020 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvAJMhrVEj0lhCeXiD2t+Sf+5S8zcMc++t+oIIyFqcc=;
        b=ofThQBp/FPnmd+jt3Us1RKqMosiZ3Ld7CXBzRMIDhVDoYmaAwBY7uU7UZ3mcqeAUgY
         rOp/qmK2OCIZ3JC4VqMneHfH983Gy421XoLJQ3vwihZRiSeHlC5zsGZshWiwBQEJkWZ3
         vJvDXa/1N/S4qiiHJuV1wyuw/LBvGPpg/zeT0km+IumovVdONxeBi34sAV0DE9r8RUCi
         BnSbWEljnUCrx48XJBdTMfPDedTQ7Q26FY+sy3jqj3mZK6IqhcTkUiEws7qZDFzwCGF9
         8qhYqIeqDEMJuXGAZ9boHindf0mteZyl3iCHYSf3f16vhvRUJmO4RehoU6COPpxa/pOG
         SSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvAJMhrVEj0lhCeXiD2t+Sf+5S8zcMc++t+oIIyFqcc=;
        b=dAYhBpdGWPKbfDZHR+Z4JFGDAgPIZKlsJpwogZGUogYyBnLskVgyn8E33Q8JoFwwBD
         cLiozWb22ppVOS+W0zu2Iwm5nUao6Ziwq4cVortnxRXYYbHhYQ7X/QTr6OJQTYAc6ROI
         tOAP2UbJ7lYAhO6l04rphpSHK08NPagJLpOmuILSQKrjvOoOmLwbU2Qc+Sl4amfDeFmU
         gs/kH8WWbWUwFE8ZVOP1XMY/Qn5lkPQw1y3i55ldmfF6saTEpMkOicZxOAJ606hoQa+o
         5YXPdhbSUZOsG5lK1e8HgIMzF/Lcy9kY042B1MSW8n2+y2cTBL6RcTcz0stwjJzbujxZ
         umvA==
X-Gm-Message-State: ANhLgQ2LsYOn+p9Mek6wLOokQPZL+KNx4fmom0r326J4mUdnhxWLW6lE
        uxH/o45bn5pCR+ZJoWTV00Std99I/nD2s94Hf2s=
X-Google-Smtp-Source: ADFU+vv3y/Han0bqNS7oHPaFZG+M0NVgMJpj16d4Bgc4iE3n14CjrUhR6lEygqPtDHjI6W5B/3MdAYQNafV5Vu0eBek=
X-Received: by 2002:aa7:de13:: with SMTP id h19mr27875188edv.52.1585059842383;
 Tue, 24 Mar 2020 07:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200324102030.31000-1-narmstrong@baylibre.com> <20200324102030.31000-5-narmstrong@baylibre.com>
In-Reply-To: <20200324102030.31000-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Mar 2020 15:23:51 +0100
Message-ID: <CAFBinCA4VwQmd5msALXUrPxJy9gmeRQ5-5=UdNvx2aCGkPq_sw@mail.gmail.com>
Subject: Re: [PATCH 04/13] usb: dwc3: meson-g12a: get the reset as shared
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:20 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> In order to support the Amlogic GXL/GXM SoCs, the reset line must
> be handled as shared since also used by the PHYs.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
