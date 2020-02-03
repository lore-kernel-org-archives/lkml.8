Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826DDC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2221582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580744503;
	bh=rJND+H1IgMZEScn18Y/+IWIriCGg1bplMWSIF9JlvME=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xT5MdTjwUA0EF9Z+UAij+6cwKf4RErc0wKeYWGcNJN/PtlJjKvbGtZ8gD9X3M5RiD
	 qVsMgHqkrsjk0F5YjZfjNsIZY2Z7WScQl8qwtvzcCC1WJSbnncJTkG8yLtozH2UsoD
	 pLLvSmBAmGGcFyIXoA4mPiSAKaCxFej+qQEVIl9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBCPlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:41:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40449 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCPlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:41:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so15111453ljo.7;
        Mon, 03 Feb 2020 07:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tr5D9ovaMOsIdOrJ5QuNqZz6SQs9+PkF6vx1Map7v/k=;
        b=fFFw6mobaogEbgl0b/xt1VD2i8AiQbQOupxn9azbHTr7FCxoddld3xUnaSezCyqoHv
         57TTThMuNpdKfLRvih/YUbzHU8PuZN90S23mvxBK8P+lSBPQdDtSzwIyy45a8/7CLAUV
         ijo9C4cUzeqb1UZzQ8k12b01HQvXvWxqIdI8xY3JTyMRm0m/fAaY2VjbexfhLcu61sJH
         OKMjMDYgc5eUJtdjgk99VQ1tQD3sqtUMF+O3zEN5dElwtdSyDhb+JWNtC9iCvXsXw2c6
         pBugdzrsJ/6XvbWCJ2DwAokL2kVeVrjnzDzrl8piAxcAJTJfpa/GnT3AbDtB28WgeOKQ
         zilA==
X-Gm-Message-State: APjAAAUfqgQVRv5YuRTaGAMH/G8rAdserOsYoEc45GujgzjUXo9MhuWs
        1zG4EB0/Egsaro+lJFg8c0o=
X-Google-Smtp-Source: APXvYqy1God+sf+I3+Dw8Z65JBsf1olps2RdgxJDykqDoM++fMB6Angb6xV8SNe5ujRtKfqZqn/tow==
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr14798308ljc.158.1580744499668;
        Mon, 03 Feb 2020 07:41:39 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id s17sm11736065ljo.18.2020.02.03.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:41:38 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iydrA-0006t7-4c; Mon, 03 Feb 2020 16:41:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, edes <edes@gmx.net>,
        Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] USB: core: add endpoint-blacklist quirk
Date:   Mon,  3 Feb 2020 16:38:27 +0100
Message-Id: <20200203153830.26394-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a new endpoint-blacklist device quirk and uses that to
ignore a duplicate endpoint in a broken altsetting of a sound card. The
last patch is just a related cleanup.

Johan


Johan Hovold (3):
  USB: core: add endpoint-blacklist quirk
  USB: quirks: blacklist duplicate ep on Sound Devices USBPre2
  USB: core: clean up endpoint-descriptor parsing

 drivers/usb/core/config.c  | 31 +++++++++++++++++++------------
 drivers/usb/core/quirks.c  | 37 +++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h     |  3 +++
 include/linux/usb/quirks.h |  3 +++
 4 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.24.1

