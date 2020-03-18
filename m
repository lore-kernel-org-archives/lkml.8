Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA47C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026632076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mjEQTlB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCRJVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:21:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46997 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:21:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so12900776wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9CPSM3TbuO9VpI+gQ3R11/NwAFhf9O4PNoFbVUCUhts=;
        b=mjEQTlB7dKBhJRDA1W85ESpVqAOYCUq8lIkXHu82ETPYYd1u0RA6ItDTWDf3K5oIXC
         PqzORIB21B9gfVEjs2qCCpAg8XTdvFZL6iSL4Owaeiu5xtwpV3/jPs9bvX3JSu17Na8i
         9QiAMxphByCGy08FDR8iDBlrI9L+FlAWk15ny5VeH7RjtzpPELiDzGH3/+V5kxNzrTZH
         XgMrnrgoIudWHzPrZaVQen13nAnD6BmQyVDJ6lDupIF9J1T/l6WXHhLYybFvS6A/qmJI
         Ovsm7aj3yhF0rNphT2JFPveOAUynpEwGY1SGFsnTm8AnWfxjgfU+fiTOycpvb0siMzVL
         qkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9CPSM3TbuO9VpI+gQ3R11/NwAFhf9O4PNoFbVUCUhts=;
        b=GseIGWkb3QB5k/YXm7AD/4SuvWmtpxif2eovQrvlmJURujWwp9sNA964L7mOEnEb6r
         KyuiSQx7ykUDbf0wLZ5M6ISXybebNOkwYjWU5CCOBzpnp/927cNQIuGEsBVF7h4TgPtN
         pUYKRIAG9Dyt12kIGhUdagQmgDRYUEIgc+obKaWer1nGKx0t/10qZlww4O1/vVBSzzw+
         mXP9r/KoqyGZZZ/t0EFmeUXxFlojRMNcNbVZrX6pWlhXyPtfFplTHLEW58TCuN7nWskD
         FD2sm2vZb98usVMiJ3Xi17fNoWoYmjC+FUjiL7kVriigKFhJ61S/ektWvu25h4Oxg4O3
         JDEQ==
X-Gm-Message-State: ANhLgQ37sYXQsrrC+PDB0HmUVS1/PcV6bAu5aRfEidSeQIfywjIX0jAd
        QgimrO3DA+kWsjlJQESHkV3dlQ==
X-Google-Smtp-Source: ADFU+vtU90fFfLgtA2miWNPm2B/BrB2G3jwqZlfxZD6DzZuctWr/P3W5RFX+wXkzi1m3eArdvItajg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr4432665wrr.393.1584523281247;
        Wed, 18 Mar 2020 02:21:21 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id n18sm8611196wrw.34.2020.03.18.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:21:20 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:21:18 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] PNP: constify driver name
Message-ID: <20200318092118.GA24828@Red>
References: <1583481181-22972-1-git-send-email-clabbe@baylibre.com>
 <a76a7dc9-4e5d-bb5b-b70c-cf6762b73f7d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76a7dc9-4e5d-bb5b-b70c-cf6762b73f7d@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 06:46:24PM +0100, Rafael J. Wysocki wrote:
> On 3/6/2020 8:53 AM, Corentin Labbe wrote:
> > struct pnp_driver has name set as char* instead of const char* like platform_driver, pci_driver, usb_driver, etc...
> > Let's unify a bit by setting name as const char*.
> > Furthermore, all users of this structures set name from already const
> > data.
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   include/linux/pnp.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> > index 3b12fd28af78..b18dca67253d 100644
> > --- a/include/linux/pnp.h
> > +++ b/include/linux/pnp.h
> > @@ -379,7 +379,7 @@ struct pnp_id {
> >   };
> >   
> >   struct pnp_driver {
> > -	char *name;
> > +	const char *name;
> >   	const struct pnp_device_id *id_table;
> >   	unsigned int flags;
> >   	int (*probe) (struct pnp_dev *dev, const struct pnp_device_id *dev_id);
> 
> Applied as 5.7 material along with the [2/2].
> 
> BTW, please CC PNP patches to linux-acpi in the future.
> 

Perhaps it is better to update MAINTAINERS ?
I will send a patch for it.
