Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67812C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 05:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3170B2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 05:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sa4beBDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgHBE5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 00:57:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56114 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725772AbgHBE5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 00:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596344243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lqm3gJ+a/A6+CZ0lVkzNAgM+WvK1msrofpDlW29H8bk=;
        b=Sa4beBDJSn3NKrZbythIM5cb8j6y2XwI5HGYoLWKBiES+Kge5YALtMkTJxNkYcIT/E59lr
        pP25VodI9zEDdJSOWNCttyV2XdmsqS/D4yeGdh+XK++7fLrY9Xnt/2KU4eTQA7AVBAMD2+
        Q8MCkN8uRmTV4KQa+0rz/sNWAIYJ5ck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-KE1qhey-NUu_GkRQrMhFzQ-1; Sun, 02 Aug 2020 00:57:22 -0400
X-MC-Unique: KE1qhey-NUu_GkRQrMhFzQ-1
Received: by mail-wr1-f71.google.com with SMTP id z12so10290857wrl.16
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 21:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lqm3gJ+a/A6+CZ0lVkzNAgM+WvK1msrofpDlW29H8bk=;
        b=R9xQdpXzrCyFVu2IXuMLcLjI3YXjplwpmmmnywFjMndoYXsFmmprIleYcyneqgOfWu
         czMbZQhU4JYAuZlNGzlxLcLa1cNb2Ao8keuI3sYQNIeKaKF2JH/fKVwmhzzsulyTYHH+
         uZT9ZeoO/RY+eI0wVxfQwGL4OKJKL21Zd8+Qszb1Sb+dKf1XsUh5Yth1x5cJkmlVdoF5
         XfnDuPyTO2GTe947/Ci+W+x39F4wWh+pf2ZT3kbm+0dqx1pacDMign4lQA8DjBRXKm6H
         HSokpBw7zYtUMUSWEATtN8S6V0aOtc/eYyvv+YnAWnEtdtWpJXdJNhNKvH9R0bjxS1BY
         ti/Q==
X-Gm-Message-State: AOAM531IG4guSJv0QpywrPBMnWFAVp53qxS2qfHGb37/e4+Dic4YSj+t
        V9lPGcAPo6s99dUj2Xx/JXS8mrxxDAsPQIlvTKqi4vLRyrC1fdY+JIVuZXdRqRUHk4riCgdCC5w
        Scbb6XhBOhMQP31QA+7ia2DOU
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr10270030wmc.30.1596344241094;
        Sat, 01 Aug 2020 21:57:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcYzalEf4ACn+DVyrE2vY0iiPikd7fc8yls81cufZrHy65zRAcH3RP0yqZoHyVHku6PkSe7A==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr10270015wmc.30.1596344240913;
        Sat, 01 Aug 2020 21:57:20 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id f16sm18988277wro.34.2020.08.01.21.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 21:57:19 -0700 (PDT)
Date:   Sun, 2 Aug 2020 00:57:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     sudeep.dutt@intel.com
Cc:     ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: sparse warnings in vop
Message-ID: <20200802005458-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Building vop with make C=1 produces the following:

CHECK   drivers/misc/mic/vop/vop_main.c
drivers/misc/mic/vop/vop_main.c:551:58: warning: incorrect type in argument 1 (different address spaces)
drivers/misc/mic/vop/vop_main.c:551:58:    expected void const volatile [noderef] __iomem *addr
drivers/misc/mic/vop/vop_main.c:551:58:    got restricted __le64 *
drivers/misc/mic/vop/vop_main.c:560:49: warning: incorrect type in argument 1 (different address spaces)
drivers/misc/mic/vop/vop_main.c:560:49:    expected struct mic_device_ctrl *dc
drivers/misc/mic/vop/vop_main.c:560:49:    got struct mic_device_ctrl [noderef] __iomem *dc
drivers/misc/mic/vop/vop_main.c:579:49: warning: incorrect type in argument 1 (different address spaces)
drivers/misc/mic/vop/vop_main.c:579:49:    expected struct mic_device_ctrl *dc
drivers/misc/mic/vop/vop_main.c:579:49:    got struct mic_device_ctrl [noderef] __iomem *dc

Would be nice to fix to silence the noise, but I'm not 100% sure
what the right thing to do here is. Tag struct members with __iomem or
cast with __force on use?

-- 
MST

