Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86B8C433FB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0AC820714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGZLjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:39:54 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:32814
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbgGZLjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:39:52 -0400
X-IronPort-AV: E=Sophos;i="5.75,398,1589234400"; 
   d="scan'208";a="355309543"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 26 Jul 2020 13:39:47 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     kernel-janitors@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] ASoC: Intel: drop unnecessary list_empty
Date:   Sun, 26 Jul 2020 12:58:26 +0200
Message-Id: <1595761112-11003-2-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1595761112-11003-1-git-send-email-Julia.Lawall@inria.fr>
References: <1595761112-11003-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_entry_safe is able to handle an empty list.
The only effect of avoiding the loop is not initializing the
index variable.
Drop list_empty tests in cases where these variables are not
used.

Note that list_for_each_entry_safe is defined in terms of
list_first_entry, which indicates that it should not be used on an
empty list.  But in list_for_each_entry_safe, the element obtained by
list_first_entry is not really accessed, only the address of its
list_head field is compared to the address of the list head, so the
list_first_entry is safe.

The semantic patch that makes this change is as follows (with another
variant for the no brace case): (http://coccinelle.lip6.fr/)

<smpl>
@@
expression x,e;
iterator name list_for_each_entry_safe;
statement S;
identifier i,j;
@@
-if (!(list_empty(x))) {
   list_for_each_entry_safe(i,j,x,...) S
- }
 ... when != i
     when != j
(
  i = e;
|
? j = e;
)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/intel/atom/sst/sst_loader.c  |   10 ++++------
 sound/soc/intel/skylake/skl-pcm.c      |    8 +++-----
 sound/soc/intel/skylake/skl-topology.c |    5 ++---
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index 8ad0ca7..fc91a30 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -276,12 +276,10 @@ void sst_memcpy_free_resources(struct intel_sst_drv *sst_drv_ctx)
 	struct sst_memcpy_list *listnode, *tmplistnode;
 
 	/* Free the list */
-	if (!list_empty(&sst_drv_ctx->memcpy_list)) {
-		list_for_each_entry_safe(listnode, tmplistnode,
-				&sst_drv_ctx->memcpy_list, memcpylist) {
-			list_del(&listnode->memcpylist);
-			kfree(listnode);
-		}
+	list_for_each_entry_safe(listnode, tmplistnode,
+				 &sst_drv_ctx->memcpy_list, memcpylist) {
+		list_del(&listnode->memcpylist);
+		kfree(listnode);
 	}
 }
 
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 89dcccd..9e15b06 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1509,11 +1509,9 @@ int skl_platform_unregister(struct device *dev)
 	struct skl_dev *skl = bus_to_skl(bus);
 	struct skl_module_deferred_bind *modules, *tmp;
 
-	if (!list_empty(&skl->bind_list)) {
-		list_for_each_entry_safe(modules, tmp, &skl->bind_list, node) {
-			list_del(&modules->node);
-			kfree(modules);
-		}
+	list_for_each_entry_safe(modules, tmp, &skl->bind_list, node) {
+		list_del(&modules->node);
+		kfree(modules);
 	}
 
 	kfree(skl->dais);
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b9aab47..b7d2d97 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3773,9 +3773,8 @@ void skl_tplg_exit(struct snd_soc_component *component, struct hdac_bus *bus)
 	struct skl_dev *skl = bus_to_skl(bus);
 	struct skl_pipeline *ppl, *tmp;
 
-	if (!list_empty(&skl->ppl_list))
-		list_for_each_entry_safe(ppl, tmp, &skl->ppl_list, node)
-			list_del(&ppl->node);
+	list_for_each_entry_safe(ppl, tmp, &skl->ppl_list, node)
+		list_del(&ppl->node);
 
 	/* clean up topology */
 	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);

