Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BF0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEDA21556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG+nuav8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgFQQ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgFQQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14831C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v13so2103016otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk3pc8AeI0c3+wdEYp+hTZYx+ewWTm/IvoUeIkfxAsE=;
        b=nG+nuav8Qw6xBb23T2t9tWvMzUDdAcso2xuwHW3zG0/KAAmHHffC3dgtlW/jK5H5uF
         0H0WW5/lFA1J7jQj3qZdLWZ2KdkqtAwzezF0+L2hzmt09jTWp7KUh+ErbuHgZuoClKPD
         w2DtAj8nf4hugN5yM9ABahO9fYEBM9Rm91W8jv2xKbf7bmDrGQobDUqNUb4rOqMRK7kr
         vVE9yYZvDHZ5/v3+nNJZl7Z1OGocZOsNsuiQZYIZtlLYlaZ1QoOTS8ueNFVPsjNVkvwa
         Q0Mopc4NZp4Tl4GMOFhoo1FKCm7Dg61wb5h4DqGsFR8s6LiDlGchJICrYcDdR/RQYqlC
         vnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk3pc8AeI0c3+wdEYp+hTZYx+ewWTm/IvoUeIkfxAsE=;
        b=PQYYCqSl+zT2rXHEk6JceaWw0BHyIDLr/10wGiewYn8x4BXY9KqGoS/Dgv5v1gLst1
         EPvAXjN9qY76s6rAY5zHDhKYin1XkCu89LfJIvzMp+r7FVxf/LBky7uGiqtIRpFWhLRZ
         Zz2RF8s7SDLcn4pTQ1UW/avtIINXTKyc14tib8r7cOy7Mvboffai1dXbqcXCXLapD5py
         iFcK1NRmlVBnhvMhPixWvmDwIhq5WkoQusMpkfiMGKGeU16br79QoJ3uNU4IZxAzhN9I
         LfyLZXudM32ovNmGIXKjhwkHQymZVHN462WtKgv9l4u+A5QwinhQmhQg2h7qSdDDqChP
         w9Sg==
X-Gm-Message-State: AOAM5329ZApPTXMZVCjiaZ+iuXSjGm9SxHLzkrwhbFRGCrDtTALn0bHU
        S5NDMYJtY6hh2KFuchNrsJY=
X-Google-Smtp-Source: ABdhPJxxoHW1tEDOZuRDffrva288t4Ajc/90lYQP2ebkwDRKVRuwohnE022y+hBEZrZgf0oEb0/kYw==
X-Received: by 2002:a9d:2de6:: with SMTP id g93mr7924661otb.28.1592411186443;
        Wed, 17 Jun 2020 09:26:26 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 15/21] dyndbg: export ddebug_exec_queries
Date:   Wed, 17 Jun 2020 10:25:30 -0600
Message-Id: <20200617162536.611386-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting ddebug_exec_queries will allow module authors using dynamic
debug to actually control/enable/disable their own pr-debug callsites
dynamically.

With it, module authors can tie any update of their internal debug
variables to a corresponding ddebug_exec_queries invocation, which
will modify all their selected callsites accordingly.

Generally, authors would exec +p or -p on some subsets of their set of
callsites, and leave fmlt flags for user to choose the appropriate
amount of structural context desired in the logs.

Depending upon the user needs, the module might be known, and
therefore a waste of screen width, function would be valuable, file
would be long and familiar to the author, etc..  That said, author
could harness the message-prefix facility if they saw fit to do so.
Any author preferences can be overridden with echo >control

Is it safe ?

ddebug_exec_queries() is currently 'exposed' to user space in
several limited ways;

1 it is called from module-load callback, where it implements the
  $modname.dyndbg=+p "fake" parameter provided to all modules.

2 it handles query input from >control directly

IOW, it is "fully" exposed to local root user; exposing the same
functionality to other kernel modules is no additional risk.

The other big issue to check is locking:

dyndbg has a single mutex, taken by ddebug_change to handle >control,
and by ddebug_proc_(start|stop) to span `cat control`.  ISTM this
proposed export presents no locking problems.

drm use case:

drm.debug=0x03 appears to be a kernel boot-arg example, setting 2
internal debug flags.  Each bit is probably controlling a separate
subset of all debug-prints, they may be overlapping subsets.

Those subsets are *definitely* expressible as a few dyndbg queries
each.  Any arbitrary subset is.

   drm.dyndbg='file drm_gem_* +p'	# gem debug
   drm.dyndbg='file *_gem_* +p'		# *gem debug

With this proposed export, drm authors could exec these examples, most
likely in the callback that handles updates to the drm.debug variable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e1dd96178f18..ff97938b5849 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -547,6 +547,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		return exitcode;
 	return nfound;
 }
+EXPORT_SYMBOL(ddebug_exec_queries);
 
 #define PREFIX_SIZE 64
 
-- 
2.26.2

