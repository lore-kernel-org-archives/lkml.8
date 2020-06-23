Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B523DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983512089D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbgFWWLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:11:44 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:45068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387840AbgFWWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:11:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 93F1F100E7B40;
        Tue, 23 Jun 2020 22:11:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: alley94_42139ce26e3f
X-Filterd-Recvd-Size: 1825
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 22:11:40 +0000 (UTC)
Message-ID: <25a963df43bfa4a1099b6813bb35d9c5a6184578.camel@perches.com>
Subject: Re: [PATCH 03/50] staging: mmal-vchiq: Avoid use of bool in
 structures
From:   Joe Perches <joe@perches.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Date:   Tue, 23 Jun 2020 15:11:39 -0700
In-Reply-To: <20200623164235.29566-4-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
         <20200623164235.29566-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 18:41 +0200, Nicolas Saenz Julienne wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> 
> Fixes up a checkpatch error "Avoid using bool structure members
> because of possible alignment issues".
[]
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
[]
> @@ -1754,7 +1754,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
>  
>  	ret = enable_component(instance, component);
>  	if (ret == 0)
> -		component->enabled = true;
> +		component->enabled = 1;

This change does not match the commit description.

Also, checkpatch does not emit a warning here.


