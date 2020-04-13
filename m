Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD2C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C41E206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgDMR5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:57:17 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:43278 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387436AbgDMR5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:57:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 106E9180A732A;
        Mon, 13 Apr 2020 17:57:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toe75_5bd65cad73310
X-Filterd-Recvd-Size: 7375
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Apr 2020 17:57:10 +0000 (UTC)
Message-ID: <c39854067e211fa6264faa82d0cd52d19466802d.camel@perches.com>
Subject: Re: [PATCH] drm/i915/gvt: Use ARRAY_SIZE instead of hardcoded size
From:   Joe Perches <joe@perches.com>
To:     Jason Yan <yanaijie@huawei.com>, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 13 Apr 2020 10:55:03 -0700
In-Reply-To: <20200413143224.22806-1-yanaijie@huawei.com>
References: <20200413143224.22806-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 22:32 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/gpu/drm/i915/gvt/vgpu.c:127:30-31: WARNING: Use ARRAY_SIZE
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/i915/gvt/vgpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
> index 1d5ff88078bd..7d361623ff67 100644
> --- a/drivers/gpu/drm/i915/gvt/vgpu.c
> +++ b/drivers/gpu/drm/i915/gvt/vgpu.c
> @@ -124,7 +124,7 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
>  	 */
>  	low_avail = gvt_aperture_sz(gvt) - HOST_LOW_GM_SIZE;
>  	high_avail = gvt_hidden_sz(gvt) - HOST_HIGH_GM_SIZE;
> -	num_types = sizeof(vgpu_types) / sizeof(vgpu_types[0]);
> +	num_types = ARRAY_SIZE(vgpu_types);
>  
>  	gvt->types = kcalloc(num_types, sizeof(struct intel_vgpu_type),
>  			     GFP_KERNEL);

It's probably better to remove num_types altogether and just
use ARRAY_SIZE in both places num_types is used.

Perhaps refactoring the function a bit more is also better.

Perhaps:

o Use ARRAY_SIZE
o Make vgpu_types static const to reduce data size and
  move the definition into the function where it's used
o Use temporaries to shorten the code indirections.

---
 drivers/gpu/drm/i915/gvt/vgpu.c | 92 +++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 1d5ff8..e56f59d 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -77,26 +77,6 @@ void populate_pvinfo_page(struct intel_vgpu *vgpu)
 #define VGPU_WEIGHT(vgpu_num)	\
 	(VGPU_MAX_WEIGHT / (vgpu_num))
 
-static struct {
-	unsigned int low_mm;
-	unsigned int high_mm;
-	unsigned int fence;
-
-	/* A vGPU with a weight of 8 will get twice as much GPU as a vGPU
-	 * with a weight of 4 on a contended host, different vGPU type has
-	 * different weight set. Legal weights range from 1 to 16.
-	 */
-	unsigned int weight;
-	enum intel_vgpu_edid edid;
-	char *name;
-} vgpu_types[] = {
-/* Fixed vGPU type table */
-	{ MB_TO_BYTES(64), MB_TO_BYTES(384), 4, VGPU_WEIGHT(8), GVT_EDID_1024_768, "8" },
-	{ MB_TO_BYTES(128), MB_TO_BYTES(512), 4, VGPU_WEIGHT(4), GVT_EDID_1920_1200, "4" },
-	{ MB_TO_BYTES(256), MB_TO_BYTES(1024), 4, VGPU_WEIGHT(2), GVT_EDID_1920_1200, "2" },
-	{ MB_TO_BYTES(512), MB_TO_BYTES(2048), 4, VGPU_WEIGHT(1), GVT_EDID_1920_1200, "1" },
-};
-
 /**
  * intel_gvt_init_vgpu_types - initialize vGPU type list
  * @gvt : GVT device
@@ -106,9 +86,32 @@ static struct {
  */
 int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 {
-	unsigned int num_types;
 	unsigned int i, low_avail, high_avail;
 	unsigned int min_low;
+	static const struct vgpu_types {
+		unsigned int low_mm;
+		unsigned int high_mm;
+		unsigned int fence;
+
+		/* A vGPU with a weight of 8 will get twice as much GPU
+		 * as a vGPU with a weight of 4 on a contended host,
+		 * different vGPU type has different weight set.
+		 * Legal weights range from 1 to 16.
+		 */
+		unsigned int weight;
+		enum intel_vgpu_edid edid;
+		char *name;
+	} vgpu_types[] = {
+		/* Fixed vGPU type table */
+		{ MB_TO_BYTES(64), MB_TO_BYTES(384), 4,
+		  VGPU_WEIGHT(8), GVT_EDID_1024_768, "8" },
+		{ MB_TO_BYTES(128), MB_TO_BYTES(512), 4,
+		  VGPU_WEIGHT(4), GVT_EDID_1920_1200, "4" },
+		{ MB_TO_BYTES(256), MB_TO_BYTES(1024), 4,
+		  VGPU_WEIGHT(2), GVT_EDID_1920_1200, "2" },
+		{ MB_TO_BYTES(512), MB_TO_BYTES(2048), 4,
+		  VGPU_WEIGHT(1), GVT_EDID_1920_1200, "1" },
+	};
 
 	/* vGPU type name is defined as GVTg_Vx_y which contains
 	 * physical GPU generation type (e.g V4 as BDW server, V5 as
@@ -124,45 +127,44 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 	 */
 	low_avail = gvt_aperture_sz(gvt) - HOST_LOW_GM_SIZE;
 	high_avail = gvt_hidden_sz(gvt) - HOST_HIGH_GM_SIZE;
-	num_types = sizeof(vgpu_types) / sizeof(vgpu_types[0]);
 
-	gvt->types = kcalloc(num_types, sizeof(struct intel_vgpu_type),
-			     GFP_KERNEL);
+	gvt->types = kcalloc(ARRAY_SIZE(vgpu_types),
+			     sizeof(struct intel_vgpu_type), GFP_KERNEL);
 	if (!gvt->types)
 		return -ENOMEM;
 
 	min_low = MB_TO_BYTES(32);
-	for (i = 0; i < num_types; ++i) {
-		if (low_avail / vgpu_types[i].low_mm == 0)
+	for (i = 0; i < ARRAY_SIZE(vgpu_types); i++) {
+		struct intel_vgpu_type *type = &gvt->types[i];
+		const struct vgpu_types *vgpu = &vgpu_types[i];
+
+		if (low_avail / vgpu->low_mm == 0)
 			break;
 
-		gvt->types[i].low_gm_size = vgpu_types[i].low_mm;
-		gvt->types[i].high_gm_size = vgpu_types[i].high_mm;
-		gvt->types[i].fence = vgpu_types[i].fence;
+		type->low_gm_size = vgpu->low_mm;
+		type->high_gm_size = vgpu->high_mm;
+		type->fence = vgpu->fence;
 
-		if (vgpu_types[i].weight < 1 ||
-					vgpu_types[i].weight > VGPU_MAX_WEIGHT)
+		if (vgpu->weight < 1 || vgpu->weight > VGPU_MAX_WEIGHT)
 			return -EINVAL;
 
-		gvt->types[i].weight = vgpu_types[i].weight;
-		gvt->types[i].resolution = vgpu_types[i].edid;
-		gvt->types[i].avail_instance = min(low_avail / vgpu_types[i].low_mm,
-						   high_avail / vgpu_types[i].high_mm);
+		type->weight = vgpu->weight;
+		type->resolution = vgpu->edid;
+		type->avail_instance = min(low_avail / vgpu->low_mm,
+					   high_avail / vgpu->high_mm);
 
 		if (IS_GEN(gvt->gt->i915, 8))
-			sprintf(gvt->types[i].name, "GVTg_V4_%s",
-				vgpu_types[i].name);
+			sprintf(type->name, "GVTg_V4_%s", vgpu->name);
 		else if (IS_GEN(gvt->gt->i915, 9))
-			sprintf(gvt->types[i].name, "GVTg_V5_%s",
-				vgpu_types[i].name);
+			sprintf(type->name, "GVTg_V5_%s", vgpu->name);
 
 		gvt_dbg_core("type[%d]: %s avail %u low %u high %u fence %u weight %u res %s\n",
-			     i, gvt->types[i].name,
-			     gvt->types[i].avail_instance,
-			     gvt->types[i].low_gm_size,
-			     gvt->types[i].high_gm_size, gvt->types[i].fence,
-			     gvt->types[i].weight,
-			     vgpu_edid_str(gvt->types[i].resolution));
+			     i, type->name,
+			     type->avail_instance,
+			     type->low_gm_size,
+			     type->high_gm_size, type->fence,
+			     type->weight,
+			     vgpu_edid_str(type->resolution));
 	}
 
 	gvt->num_types = i;




