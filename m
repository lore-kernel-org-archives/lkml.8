Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D9FC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8A1208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="V2x5CcAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGSPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 11:52:20 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:53936 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgGSPwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:52:19 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jul 2020 11:52:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Disposition:
        Content-Transfer-Encoding; bh=nLgoWePWpiGRb9MQLcDy7kVpH9lYYEUHpm
        +ppMx20Fc=; b=V2x5CcAbYVxuE1BKBUl7fMe39rKDy2n2vkeMYT3NzlPFht9v3n
        Zcvtb3NAl/a8BeD8oktsga0a9lxDUQE86jqGfsjQj3gJWmJF/ks/0d3tZICg57F8
        djnO3voddKoUdWRp0OQQZEdOj/QRQ7bZlnXFfJgiTXSaBRrlixPrwbQEI=
Received: from xin-virtual-machine (unknown [111.192.165.241])
        by app2 (Coremail) with SMTP id XQUFCgCHjLypahRfupwJAg--.48S3;
        Sun, 19 Jul 2020 23:45:48 +0800 (CST)
Date:   Sun, 19 Jul 2020 23:45:45 +0800
From:   Xin Xiong <xiongx18@fudan.edu.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xin Xiong <xiongx18@fudan.edu.cn>
Subject: [PATCH] drm: fix drm_dp_mst_port refcount leaks in
 drm_dp_mst_allocate_vcpi
Message-ID: <20200719154545.GA41231@xin-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: XQUFCgCHjLypahRfupwJAg--.48S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWktF47Cr17JrW5ZFyDGFg_yoW8CF1xpF
        W7Kryjvr9Yva1Dta1Uu3WkCr4kuanFvF1xJrWUCw17u34Utr1FqF15Gw1aqFy7ArWxtFyF
        qanFkF48CF129aDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xr
        Wl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
        JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
        AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8fHUUUUU
        U
X-CM-SenderInfo: arytiiqsuqiimz6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_dp_mst_allocate_vcpi() invokes
drm_dp_mst_topology_get_port_validated(), which increases the refcount
of the "port".

These reference counting issues take place in two exception handling
paths separately. Either when “slots” is less than 0 or when
drm_dp_init_vcpi() returns a negative value, the function forgets to
reduce the refcnt increased drm_dp_mst_topology_get_port_validated(),
which results in a refcount leak.

Fix these issues by pulling up the error handling when "slots" is less
than 0, and calling drm_dp_mst_topology_put_port() before termination
when drm_dp_init_vcpi() returns a negative value.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 1e26b89628f9..97b48b531ec6 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4261,11 +4261,11 @@ bool drm_dp_mst_allocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 {
 	int ret;
 
-	port = drm_dp_mst_topology_get_port_validated(mgr, port);
-	if (!port)
+	if (slots < 0)
 		return false;
 
-	if (slots < 0)
+	port = drm_dp_mst_topology_get_port_validated(mgr, port);
+	if (!port)
 		return false;
 
 	if (port->vcpi.vcpi > 0) {
@@ -4281,6 +4281,7 @@ bool drm_dp_mst_allocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 	if (ret) {
 		DRM_DEBUG_KMS("failed to init vcpi slots=%d max=63 ret=%d\n",
 			      DIV_ROUND_UP(pbn, mgr->pbn_div), ret);
+		drm_dp_mst_topology_put_port(port);
 		goto out;
 	}
 	DRM_DEBUG_KMS("initing vcpi for pbn=%d slots=%d\n",
-- 
2.25.1

