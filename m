Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B526A20759
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cbuvro59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgGWOWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:22:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35461 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726815AbgGWOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595514140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=zSZAhL25JSXHpF0bAbKJRfBjeCgJ6YYI4dxlYgSnMIw=;
        b=Cbuvro597snkLvrAHWM+a9elIWOJgEr0VAHsxk9dk5zy/VNpalTniVsbmh0gGJp15JLIaQ
        OPm5R/VyR8TiHV6cIrh4rh8nrO2KAJN2dHZxeQZFKZfhlxbJeWAnzptrKflHz+SKtKUzW8
        K+uI6hiLd+CN3J2zxetuI0uqhEE3Eno=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-7R6QeyniNQ2a-anay2-ICg-1; Thu, 23 Jul 2020 10:22:16 -0400
X-MC-Unique: 7R6QeyniNQ2a-anay2-ICg-1
Received: by mail-qt1-f198.google.com with SMTP id i5so3775566qtw.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zSZAhL25JSXHpF0bAbKJRfBjeCgJ6YYI4dxlYgSnMIw=;
        b=OzN587deUf8whyb/QdCCZ8I27Qv2BxpOpXbhrrSclQgo7scKT7lSN05fpJu9rIHHTi
         w2id6dHpuE8CZvu9tg/8tDbm6+fmK0umxeF1yyyzJ+kRxI5glR+ve0kvc6BImaDOrGY8
         6DaRGm6kHYToyBgMe6aYEZY40FMI6ArUYXv3CDoizuYyZu7KZU8odRdgtDRL81qvySvM
         NtFZejs88b4fGMai/66mrw3t3hPSuaZ2zE/ACwrGRnWdZ/9pPx/318TbENyk1bWF9QhK
         2lQz1z4UhNTkiklTzUNlW07NGWyRJH63Hy+RAs2oqNnu3tQYk6vp6VxikP3Cj5+mmH4v
         LMPg==
X-Gm-Message-State: AOAM530pJwt/yeaTBeAdIxVKeJ9UTFPXAmScVVYs7og9xqExSONfQism
        PVPIf4/NnMBUgDU3Y+Lh+875py8YapiUMZgm+CyLb10/LaxvYBGdVCJcBp4yavtq4ewk5gd6HKZ
        y3qom3Nlg9+Ki6drrcJOdRRDj
X-Received: by 2002:ad4:4bb0:: with SMTP id i16mr5099826qvw.42.1595514136253;
        Thu, 23 Jul 2020 07:22:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+P4z/SKan23uckp0U4ZwHA1Evj9o8JlarlIuBAqm40uOmGWRZUthDHWilRj8lh/rxbybNZQ==
X-Received: by 2002:ad4:4bb0:: with SMTP id i16mr5099803qvw.42.1595514136058;
        Thu, 23 Jul 2020 07:22:16 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f53sm2225651qta.84.2020.07.23.07.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 07:22:15 -0700 (PDT)
From:   trix@redhat.com
To:     davem@davemloft.net, kuba@kernel.org, masahiroy@kernel.org
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: cdc_ncm: USB_NET_CDC_NCM selects USB_NET_CDCETHER
Date:   Thu, 23 Jul 2020 07:22:10 -0700
Message-Id: <20200723142210.21274-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A link error

ld: drivers/net/usb/cdc_ncm.o:
  undefined reference to `usbnet_cdc_update_filter'

usbnet_cdc_update_filter is defined in cdc_ether.c
Building of cdc_ether.o is controlled by USB_NET_CDCETHER

Building of cdc_ncm.o is controlled by USB_NET_CDC_NCM

So add a select USB_NET_CDCETHER to USB_NET_CDC_NCM

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/usb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index a7fbc3ccd29e..c7bcfca7d70b 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -252,6 +252,7 @@ config USB_NET_CDC_EEM
 config USB_NET_CDC_NCM
 	tristate "CDC NCM support"
 	depends on USB_USBNET
+	select USB_NET_CDCETHER
 	default y
 	help
 	  This driver provides support for CDC NCM (Network Control Model
-- 
2.18.1

