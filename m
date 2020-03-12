Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D62C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561F8206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="mGfn/mW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCLQ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:56:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43137 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgCLQ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:56:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125so6162529oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bJeVGEOJhQ3x+LqFHnf/RuYaBCYgW0ykaFTq1t4JHtY=;
        b=mGfn/mW/GoolbcV1PTc0a85MLhWgtdyvNluKrc1aRBFsd2QA214Z2FIRHr6qXFrLE5
         Y2btm9JK2aj6Cp3Mwq5gm3GmA4HoVOppI1yVl/nZa77/TLN535iCt3mmQgwYIrcybMM0
         m4pISxv1imNPGD0K9zjmrTTyaYl4pmiMq8ULbbovLr+t96jPx37NN8q/04C7/v8IbRAM
         MNns0d8Jne/+FfP9nAsl9OqEebqJLGUDcxo4Md86P0bE8UZdoHa2SJkz8ZK5NAS5pgQM
         hnOwnLS/Ub7C444g7x8bWrqrQEmJoRtRAcqi0IpHCv+R3W7paizvbz/5t7e7BKej2tiV
         8pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bJeVGEOJhQ3x+LqFHnf/RuYaBCYgW0ykaFTq1t4JHtY=;
        b=a9EALmRRidhX59nRSk0hFk56eehjNFBoTJhcxWPVjejm8hQCOeqjhvN8bGtz9oAj//
         0AKOyIpnc50JPk0kPq3MS+pJfwajO4pXpy1cgouL6B5ZHqbZeGYNbTBCUnWUAoa3nGJT
         u96jyCH0Bv8gQItWoCyjuwIDwztDz1zGO32We3o28HPcJYbpigMzoDfh3V5FwawY0ISv
         hjdbg+gfqgN7cOwcENx4UvhfhVQTjaQIk8Wsv420lrxWxbdAVgs0Q3Cvo4gUH7ubLhP1
         TpZyqD49p5BMu/OZdIWP4vBhiH0neM6fZdxq6Po4zQTB07uom0jwy8K18pQCfrcdAF2W
         FByw==
X-Gm-Message-State: ANhLgQ076Ax0DMUnhxA8nl+Ia8wp7S1OE9ACdYBhE3VDGpg5NwSiZ9/T
        o76iLoxrFQF89n11cXhXN8R+5i5SRLpfyT5GBzlFaQ==
X-Google-Smtp-Source: ADFU+vvOMmNr555vZMWCxUmatM3kGJLJ4GvExcQYufxjK1GmyDHGmItqGwArj2E0OMryPp55g01pjDTJ1yP7subYJJo=
X-Received: by 2002:aca:474e:: with SMTP id u75mr3226841oia.52.1584032173760;
 Thu, 12 Mar 2020 09:56:13 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 12 Mar 2020 09:56:02 -0700
Message-ID: <CAJ+vNU3Rc1xf_vVVEONgExfpGCXC97zKZZq70iE6L2L4VKf4ZQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround Cavium erratum 38539 when
 reading GICD_TYPER2
To:     maz@kernel.org
Cc:     catalin.marinas@arm.com, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, msalter@redhat.com,
        rrichter@marvell.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves failure to boot on OcteonTX (TX1).

Fixes: f2d8340 ("irqchip/gic-v3: Add GICv4.1 VPEID size discovery")
Tested-by: Tim Harvey <tharvey@gateworks.com>

Tim
