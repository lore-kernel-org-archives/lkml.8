Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59163C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275E720578
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="A5oPi8I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgESXL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgESXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:11:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D273C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:11:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z26so622872pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lx7UJrQLBWSojDrUx+gUmzxXfR3CRe9hyj+Wu8TV59E=;
        b=A5oPi8I5sC1vfxsrl1SRotsn0XbQlnU4l+EniyKtzY0siFWyg6jLea3qRNwgDiFZd1
         z4NM+aZAM2If7cQMOkmhbi2//3CMrdMvRKIQ3xDem4GqVU5elpaHvRgiz2O9D81+ief/
         G6ffhFeUe3LKqzIj1In5sAXgCEd2hC5dXQ3Vft77LMk06G6RwqXVLBYke2ooTXHPa1IZ
         Xjy+l7Q90/SKSaW6sujHObI0N36jWxj2DNqEorK3b0K4lNavJZUYOQjrCE9y1XyM13rc
         Ai2IzZAgKw1eYrYF6wRtZQcKTcgmDsLfK6QHfUtXsIWuuK5mk3izlz61DOk8PZH+OF32
         1v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lx7UJrQLBWSojDrUx+gUmzxXfR3CRe9hyj+Wu8TV59E=;
        b=PXiPgEKKFWCoJx53jqk5Fqu6BQsGXfei9VjaDdCyNa58v4PVOEq7+ySls2ErlH8eWB
         PGzvlmV46CS4cZMD4kChSTbQ8TguHJtU38DKJNww9AwqLdEX8y4VPYqM02pAJttlNonr
         u0tZPhvkxhO/W5vdulZ9y8EGrEBBSYRxrCwDVRIGmTaHUEjSfjpWXbPtEsJ/hnU9++JF
         Inoco3FKdx1mniDHZAI2dSJvz4p7ol3NSal3vBNnX+sLKY5Td8Ae8YBJp7QvVKK2xHHq
         3MTfq7jCNE72NJlixJGNEZJd9Llx6tS79IeT+sTnKvv9eUyFKeGz5Nt3VopszhBLJfYn
         HyMg==
X-Gm-Message-State: AOAM532bdKEJuHW7GJXWOKdBjdwhOPMXBlWicjz8ORrrlhOTCP2bBFlV
        WKv19cD6apnSjmNd/KoMYU6cPkOc7H+Hug==
X-Google-Smtp-Source: ABdhPJxsn0827XE2LOmPwBfl0cphgvNpH894AcJ7kRUW9DLwqSEUoaYm2yWR1fAAETXit5YR1DXd/g==
X-Received: by 2002:a62:4dc3:: with SMTP id a186mr1327386pfb.269.1589929914830;
        Tue, 19 May 2020 16:11:54 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 192sm426908pfu.182.2020.05.19.16.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 16:11:54 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: meson: add the gadget mode properties to the USB0 controller
Date:   Tue, 19 May 2020 16:11:53 -0700
Message-Id: <158992990571.5859.7805491457862081284.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504195105.2909711-1-martin.blumenstingl@googlemail.com>
References: <20200504195105.2909711-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 21:51:05 +0200, Martin Blumenstingl wrote:
> Testing with a USB RNDIS connection and iperf3 gives the following
> results:
> - From the host computer to the device at ~250Mbit/s
> - From the device to the host computer at ~76Mbit/s

Applied, thanks!

[1/1] ARM: dts: meson: add the gadget mode properties to the USB0 controller
      commit: 9530dcf1082da23438ee557291c07d475128f63a

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
