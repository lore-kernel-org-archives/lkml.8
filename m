Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0BFC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED8220CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578958506;
	bh=S1NaguMR9V42wx+4NBdr8/GDzglDpxcOx6sESbSOMC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kCCtAWihvjBy+Ku2uZzpd1dhUbgXnOOEqWEQQ6Ug8MvimHnW6GAmUoqZiz1G20Gbh
	 1lPcS9aeFJrzp7ww7CAztJBvmo/OiNK4B8hA1aOz6jPjinPziW+yiv+0rRB+nykm+F
	 1k2RE2Udxb+hgEHcyvgccdVsrGJlSToQgBDcEUgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAMXfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:35:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46895 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMXfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:35:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id r9so10732802otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hWr5fTf0UvM/FdokqnbY78OahK5vgKtckbIjPFsKcM=;
        b=ZLSZiP+bHQ540gz6rC1y9KRpemAw7furEnO8vd96Sa6XXIa0lQaflGaPYv6rUUPEAe
         F2oa43pqSqfyjlNwjUswNIFsFiRwBgoViOM7FQaNlh+jrxlbKiPxiBktUsVggIcRkur1
         eh/ogtQ8/ks3mdWGjXZ9NwDptWpATHDm0PDTeIkUzznMUzX3zSZcIpHa/oWX+nwF4JUK
         o+hB/JjdmmK6BgqqHhc2Lz1y0mxi8OgeOJajjz/6lXPtNokfn4iaycQiDL/yNcQ5giKT
         I0DiQ/IlbNESMwTwzcEn58J3QQ6PXXKTBzpLGUtFW6pB5PIHxklzsZ36KOR2hru6huby
         OF3g==
X-Gm-Message-State: APjAAAV4D0V2ASRrupjSVDcm5CGQiM2Un8AzsApKCpg1wUcd/4KdP8fo
        hSdVFpf7mRgzjGARK+VhJAYKlYQ=
X-Google-Smtp-Source: APXvYqy0w/Tg/YS9cTLAv3UVL4gQPYqHANwcZxreEKO74KTWyCKv75NDAPdhiPe2S64MgKahAf+9SA==
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr15366960oti.180.1578958504297;
        Mon, 13 Jan 2020 15:35:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s83sm4021238oif.33.2020.01.13.15.35.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:35:04 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 223f23
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:25:51 -0600
Date:   Mon, 13 Jan 2020 17:25:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 05/17] dt-bindings: atmel-isi: add
 microchip,sam9x60-isi
Message-ID: <20200113232550.GA2344@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:17:57 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-isi to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/atmel-isi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
