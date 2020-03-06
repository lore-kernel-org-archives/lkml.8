Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B8AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4A02073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="Em4FnE3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCFQII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:08:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35439 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgCFQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:08:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id v10so2927952otp.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 08:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LC6fYzrXvQrjxYDrnEIkTo21CADYi8sV2Co7PyB612o=;
        b=Em4FnE3PMcg/WJr4+ZZxzWpxxSoKfbxuzSM5MUfpkLsbTVlEXeYbbYwoUnxXmVz69j
         Iqb7SraT2u9Q6F8bMg2vRFiX/HmlLM5dgTUpWL5od1AFfc2p9mnuscx1OFecr72ABli/
         0hpiyenMdchTPAxl5tdGTjAKLT82q1DvF2Z4n92MPD6OKEUlCIAowJxgyot3mwEO3Ale
         9zIoRQiRzK4TID3SuMIB/U3VyxPvgP6ovn23L/Y291FSZGvM0lDYFN/zBLVMH5iTq4Vp
         KChUM1kPuRflNvko9QQg7hFH0gnXCoRVOUAXu5Ww215JsyK/05x5wSaTmFPiac0a80/K
         tCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LC6fYzrXvQrjxYDrnEIkTo21CADYi8sV2Co7PyB612o=;
        b=oE8gWqSuRwO9L0bGlqL/USoRb1RbT6l8/NCkAqQ6YqXN/MnMUrDjOKIph5h4rjzr9t
         9O7w6VAOOdb0HB5NdVocSLUrxB4x0zTusox4XqT1Q/fegKIe6BeQwr6tNKFbxL72j04u
         w6iA/lycqc8OawZNG6rkUxu2Cokn9PJ6KkaFY7j8fWb4urXcysorlUBMnAnMZ8BEiTZH
         As5hxD4+DJ7HD8xB2nOdjN8kx8Gs/Ow2Hs+EZI2dPww9wdioxSjspSGb1nAk6OBpNK2M
         V1V9ePmjB2sEynbGxqqro5rah+T9zt80GFV4wjsSEyE2aDy4dgvSEb7oq/YfnfAde9mQ
         bMKQ==
X-Gm-Message-State: ANhLgQ1Ex46rn9Rtvu9+jiS+6sCjLP0BQDKLKq57dtk7aryVu6Tkn43t
        K7SIvbuY91V3XLzJzDUBAd8P6WOkmFPOLIs4dPsdIA==
X-Google-Smtp-Source: ADFU+vsNOqF1Gnn9gVAlK3MDDr9UJefA8cNJowONg8rgYvH5SxZps7BFriCK6uP0ehSTEA8IezBvGKF2Ku8ePhgAtxw=
X-Received: by 2002:a9d:5cc4:: with SMTP id r4mr3190223oti.33.1583510885541;
 Fri, 06 Mar 2020 08:08:05 -0800 (PST)
MIME-Version: 1.0
References: <1582577665-13554-1-git-send-email-tharvey@gateworks.com>
 <1582577665-13554-4-git-send-email-tharvey@gateworks.com> <20200303205408.GA19757@roeck-us.net>
In-Reply-To: <20200303205408.GA19757@roeck-us.net>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 6 Mar 2020 08:07:54 -0800
Message-ID: <CAJ+vNU359PicGLtFr-s+arf210LtBH5OpBsbnbDd7otC1WBkhw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] hwmon: add Gateworks System Controller support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Robert Jones <rjones@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 12:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Feb 24, 2020 at 12:54:25PM -0800, Tim Harvey wrote:
> > The Gateworks System Controller has a hwmon sub-component that exposes
> > up to 16 ADC's, some of which are temperature sensors, others which are
> > voltage inputs. The ADC configuration (register mapping and name) is
> > configured via device-tree and varies board to board.
> >
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> Couple of minor comments, otherwise looks good from my perspective.
>

Guenter,

Thank you for the review! I will post a v6 as soon as I get the dt
bindings worked through.

Tim
