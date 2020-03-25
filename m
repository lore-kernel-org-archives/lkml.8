Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3AFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764FB20737
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMvoS3tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCYVXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:23:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38519 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgCYVXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:23:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so1310542plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D50Ea1KkZKi7MRIpZ2tdbEpQFy9vwTNoscFn6swOS/0=;
        b=EMvoS3tq9nhI2rqp5Wg+ogOhZR97+iLl7eEsa2La3ApbUDZFA/dOSiObyzdlJ2ZPXK
         2OPPTjtyXsxvP4+WJXOzeABy4EuHuPtg7ffJfknHfk7CJ4s2GPVTYIiv/7FgypPBNg9L
         farz9a7IOdydKsycs7pw2emyg7iZ9+bz0rx+JjHp96HcmnElRd/TDAI2CzobHLjl+MeH
         BsI92ipo15AxcEp2HM/PsMDE8wRpApQfW5lYPVVqTrhHPOMJbMIoPM7muPZxdvrUDnMK
         c3AX+vGHZe6RcPSJ0IKwA5+oC4JPjL4939SEIbjKj2IDX8h+SDZsfdbw26BRKkmAQu1u
         jYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D50Ea1KkZKi7MRIpZ2tdbEpQFy9vwTNoscFn6swOS/0=;
        b=GXySKFspXslhWvW9UFAWxhwRJKzhI9/ciEsXn47ORszNpakIObibtkePMfZyzw6IHa
         vbtL3FlMpEM4cb/lhvke0eDPN+/ZFem84b8q0rOsBBj8fCPYQOO672JaYDO8APY+mORl
         dECsgjbNz4H2VuDJEXf/NffGiKWAhgKjuVF6WYjNDTAczto4lySTf2sRQxtFqc6sAfqQ
         Y4dXFLKRRHgwVwp1sdaqDS4C/HssL8sFwaYxwWOdQwxpG+DpOLC85k8Qb26vpa/S8gEr
         RrAfzYBECqXw7vUS3aTT0ZvRyYQsoayFNYTjX9sEz/8+z6UQM6eAAy7tKrSGpp3icwY0
         lNZA==
X-Gm-Message-State: ANhLgQ3mNZIjk3lGsn0pkqUJwtr7kbNWKwGwFxRlXgjHrHdnODhfBi2D
        SDN8cdESe8z6pRSX0ShYVhzXskphw48=
X-Google-Smtp-Source: ADFU+vtGiKx+fvpLni/eId9KdGRM9bn4thszOD2hOrFGUDIqycCDJkcyspUHr6OuWqonoWDLtgHohg==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr5096140plk.279.1585171379953;
        Wed, 25 Mar 2020 14:22:59 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id s14sm77650pgl.4.2020.03.25.14.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:22:58 -0700 (PDT)
Date:   Thu, 26 Mar 2020 02:52:53 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: rtl8723bs: rtw_cmd: Compress lines for immediate
 return
Message-ID: <20200325212253.GA8175@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compress two lines into a single line if immediate return statement is found.
It also removes variable cmd_obj as it is no longer needed.

It is done using script Coccinelle.
And coccinelle uses following semantic patch for this compression function:

@@
expression ret;
identifier f;
@@

-ret =
+return
     f(...);
-return ret;

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 744b40dd4cf0..42b0ea8abd9c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -362,11 +362,7 @@ int rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 
 struct	cmd_obj	*rtw_dequeue_cmd(struct cmd_priv *pcmdpriv)
 {
-	struct cmd_obj *cmd_obj;
-
-	cmd_obj = _rtw_dequeue_cmd(&pcmdpriv->cmd_queue);
-
-	return cmd_obj;
+	return _rtw_dequeue_cmd(&pcmdpriv->cmd_queue);
 }
 
 void rtw_free_cmd_obj(struct cmd_obj *pcmd)
-- 
2.17.1

