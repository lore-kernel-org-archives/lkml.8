Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B8C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545B920848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="0JpQY9ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCIIYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:24:37 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:20956 "EHLO mx02-sz.bfs.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbgCIIYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:24:36 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx02-sz.bfs.de (Postfix) with ESMTPS id 67CA12034C;
        Mon,  9 Mar 2020 09:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1583742273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaIxDNUTjnov42I+Fqezs7SqV36FPgBJnmtmK2sN1WY=;
        b=0JpQY9ir9n/8J66CFLcQZ8BXSKDe93gMgEzEPknfOyXaJbubGwafmD+04QOQF9/jbM/mj/
        cOAvWou0719msxjBPi8mQ89zDzcTEdmGfVucApOhHi/ROByjo9R93APyJ46U4721aB8GjV
        IoV8xLlzkUdYoRl9q1Q6+2gCMwxkJYiFjOxrBHB1Q3QtxdNL3unL8aUrztQG9Eso+8CqnM
        SDKqffRBgIdRy2cJLCYVFBM2taEe1lrJ0Pf1P8wQ9Jp7DAd5gmVGHvOtivamDJkaS2+71A
        vQdwgF5qpg2o/PepMgXAkPy6On6l7lYgeEyiegs9hcVCwLGGqlBylWL+kVevbA==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Mon, 9 Mar 2020
 09:24:04 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Mon, 9 Mar 2020 09:24:04 +0100
From:   Walter Harms <wharms@bfs.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "David1.Zhou@amd.com" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
        "Bhawanpreet.Lakha@amd.com" <Bhawanpreet.Lakha@amd.com>,
        "mario.kleiner.de@gmail.com" <mario.kleiner.de@gmail.com>,
        "David.Francis@amd.com" <David.Francis@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH] drm/amdgpu/display: Fix an error handling path in
 'dm_update_crtc_state()'
Thread-Topic: [PATCH] drm/amdgpu/display: Fix an error handling path in
 'dm_update_crtc_state()'
Thread-Index: AQHV9SuzYuuVSz+HgUqDARTjMCrA+ag/7Vf/
Date:   Mon, 9 Mar 2020 08:24:04 +0000
Message-ID: <97d88948e2ab4ec19c5a0c6d064df08b@bfs.de>
References: <20200308092637.8194-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200308092637.8194-1-christophe.jaillet@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: mx02-sz.bfs.de;
        none
X-Spamd-Result: default: False [-1.15 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[wanadoo.fr,gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_HAM(-2.65)[98.46%];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[16];
         NEURAL_HAM(-0.00)[-0.574,0];
         FREEMAIL_TO(0.00)[wanadoo.fr];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
Von: kernel-janitors-owner@vger.kernel.org <kernel-janitors-owner@vger.kern=
el.org> im Auftrag von Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Gesendet: Sonntag, 8. M=E4rz 2020 10:26
An: harry.wentland@amd.com; sunpeng.li@amd.com; alexander.deucher@amd.com; =
christian.koenig@amd.com; David1.Zhou@amd.com; airlied@linux.ie; daniel@ffw=
ll.ch; nicholas.kazlauskas@amd.com; Bhawanpreet.Lakha@amd.com; mario.kleine=
r.de@gmail.com; David.Francis@amd.com
Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-k=
ernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe JAILLET
Betreff: [PATCH] drm/amdgpu/display: Fix an error handling path in 'dm_upda=
te_crtc_state()'

'dc_stream_release()' may be called twice. Once here, and once below in the
error handling path if we branch to the 'fail' label.

Set 'new_stream' to NULL, once released to avoid the duplicated release
function call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Maybe the 'goto fail' at line 7745 should be turned into a 'return ret'
instead. Could be clearer.

No Fixes tag provided because I've not been able to dig deep enough in the
git history.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97c1b01c0fc1..9d7773a77c4f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7704,8 +7704,10 @@ static int dm_update_crtc_state(struct amdgpu_displa=
y_manager *dm,

 skip_modeset:
        /* Release extra reference */
-       if (new_stream)
-                dc_stream_release(new_stream);
+       if (new_stream) {
+               dc_stream_release(new_stream);
+               new_stream =3D NULL;
+       }


dc_stream_release() is NULL-checked, so the if can be dropped.

re,
 wh

        /*
         * We want to do dc stream updates that do not require a
--
2.20.1

