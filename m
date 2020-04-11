Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB830C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781AD2137B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607087;
	bh=MesyVyOKCevRf+2TnmIg4GCFkNmuAs9DzQo/LPs8jfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uY36pyKO7izdgMT/cypWaOm/v0pLZhcc+RO2lAkOrLzfOk1HH0kdG6ooGsOBmUDVZ
	 ASnlq7HIlkHCsrb5iuVzyAbCxyWYe/3JhVBAjqXDT9QKLdDwiX7liWs8A3YUeqO0AU
	 j2GA47NEGmr8OK61wnDew37ucgaE3V6BBGJr7aNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgDKMLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgDKMLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:11:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3346E20787;
        Sat, 11 Apr 2020 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607080;
        bh=MesyVyOKCevRf+2TnmIg4GCFkNmuAs9DzQo/LPs8jfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlxn/cIGHJwETNGG3tF4Nflkdvxs7BZU08TIog3246WfnsMgpkaASgrRzCWZ54A+c
         hqVWJ84XbInLtwUHdBsIBL0lGwxuGFzW0ulZP+0/3W78Mh1r3xohRfu6vDN0pKoi3x
         3o2J86VbfPmdqGogZ6kry2gOdcG3FzSfHcM6HfnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 29/29] drm_dp_mst_topology: fix broken drm_dp_sideband_parse_remote_dpcd_read()
Date:   Sat, 11 Apr 2020 14:08:59 +0200
Message-Id: <20200411115412.719714953@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115407.651296755@linuxfoundation.org>
References: <20200411115407.651296755@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

commit a4c30a4861c54af78c4eb8b7855524c1a96d9f80 upstream.

When parsing the reply of a DP_REMOTE_DPCD_READ DPCD command the
result is wrong due to a missing idx increment.

This was never noticed since DP_REMOTE_DPCD_READ is currently not
used, but if you enable it, then it is all wrong.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/e72ddac2-1dc0-100a-d816-9ac98ac009dd@xs4all.nl
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_dp_mst_topology.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -431,6 +431,7 @@ static bool drm_dp_sideband_parse_remote
 	if (idx > raw->curlen)
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
+	idx++;
 	if (idx > raw->curlen)
 		goto fail_len;
 


