Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 06:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F29F206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 06:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgGZGmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 02:42:35 -0400
Received: from cmta19.telus.net ([209.171.16.92]:59288 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgGZGmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 02:42:35 -0400
Received: from montezuma.home ([154.5.226.127])
        by cmsmtp with SMTP
        id zaMhjwCJppULuzaMjj4Iu0; Sun, 26 Jul 2020 00:42:33 -0600
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=T9TysMCQ c=1 sm=1 tr=0
 a=f8b3WT/FcTuUJCJtQO1udw==:117 a=f8b3WT/FcTuUJCJtQO1udw==:17
 a=9cW_t1CCXrUA:10 a=kj9zAlcOel0A:10 a=7_-JGBSJ5swynKZTmz8A:9
 a=3HOybB5aJD7W6W9j:21 a=-JwimHSkgOrMrb_B:21 a=CjuIK1q_8ugA:10
Date:   Sat, 25 Jul 2020 23:42:31 -0700 (PDT)
From:   Zwane Mwaikambo <zwane@yosper.io>
cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix USB Type C hub crash in
 typec_altmode_update_active
In-Reply-To: <alpine.DEB.2.21.2007252222310.11533@montezuma.home>
Message-ID: <alpine.DEB.2.21.2007252334190.11533@montezuma.home>
References: <alpine.DEB.2.21.2007252222310.11533@montezuma.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfCTEhY991b1GxSJFaejtxOhKQKGpY8hPFZEAbmE/rOtpgxKs7NGvYrq4ms5Qkk50Nn7nBWyx/DdZJLV0NiGYCzlM1jRULIExrC2WPnkL1ETI/+sg7vDk
 7oBkd9/NAG8zmug2HE9VW8yOoahkD90qCPFV+i/5dafSz/0HiA8wz0g9wxusdTLzY2zLdI/rqAUvHQ==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020, Zwane Mwaikambo wrote:

> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index d0c63afaf..30d0857e4 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -218,9 +218,12 @@ void ucsi_altmode_update_active(struct ucsi_connector *con)
>  	if (cur < UCSI_MAX_ALTMODES)
>  		altmode = typec_altmode_get_partner(con->port_altmode[cur]);
>  
> -	for (i = 0; con->partner_altmode[i]; i++)
> -		typec_altmode_update_active(con->partner_altmode[i],
> -					    con->partner_altmode[i] == altmode);
> +	for (i = 0; i < UCSI_MAX_ALTMODES; i++) {
> +        if (con->partner_altmode[i]) {
> +		    typec_altmode_update_active(con->partner_altmode[i],
> +			                            con->partner_altmode[i] == altmode);
> +        }
> +    }
>  }
>  
>  static u8 ucsi_altmode_next_mode(struct typec_altmode **alt, u16 svid)
> 

Previous patch had whitespace issues and i cleaned it up for coding style 
reasons, patch is against 5.8.0-rc6

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index d0c63afaf..30e811fde 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -218,9 +218,10 @@ void ucsi_altmode_update_active(struct ucsi_connector *con)
 	if (cur < UCSI_MAX_ALTMODES)
 		altmode = typec_altmode_get_partner(con->port_altmode[cur]);
 
-	for (i = 0; con->partner_altmode[i]; i++)
-		typec_altmode_update_active(con->partner_altmode[i],
-					    con->partner_altmode[i] == altmode);
+	for (i = 0; i < UCSI_MAX_ALTMODES; i++)
+		if (con->partner_altmode[i])
+			typec_altmode_update_active(con->partner_altmode[i],
+										con->partner_altmode[i] == altmode);
 }
 
 static u8 ucsi_altmode_next_mode(struct typec_altmode **alt, u16 svid)
