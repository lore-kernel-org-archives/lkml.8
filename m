Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE31206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMM7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:59:23 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:51554 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbgCMM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:59:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CFC0318010A45;
        Fri, 13 Mar 2020 12:59:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: idea77_3485785e1df18
X-Filterd-Recvd-Size: 3039
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Mar 2020 12:59:20 +0000 (UTC)
Message-ID: <d67ed65313f3a1579c1cf88348e8853c5cca4598.camel@perches.com>
Subject: [PATCH] drm/amd/powerplay: Move fallthrough; into containing
 #ifdef/#endif
From:   Joe Perches <joe@perches.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Mar 2020 05:57:37 -0700
In-Reply-To: <20200313205748.03d30145@canb.auug.org.au>
References: <20200313205748.03d30145@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The automated conversion of /* fallthrough */ comments converted
a comment outside of an #ifdef/#endif case block that should be
inside the block.

Move the fallthrough inside the block to silence the warning.

Signed-off-by: Joe Perches <joe@perches.com>
---

On Fri, 2020-03-13 at 20:57 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:
> 
> In file included from include/linux/compiler_types.h:59,
>                  from <command-line>:
> drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.c: In function 'smu7_request_link_speed_change_before_state_change':
> include/linux/compiler_attributes.h:200:41: warning: statement will never be executed [-Wswitch-unreachable]
>   200 | # define fallthrough                    __attribute__((__fallthrough__))
>       |                                         ^~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.c:3706:4: note: in expansion of macro 'fallthrough'
>  3706 |    fallthrough;
>       |    ^~~~~~~~~~~
> 
> Introduced by commit
> 
>   e86efa063cd1 ("AMD POWERPLAY: Use fallthrough;")

This is also one of the #ifdef/#endif pairs
where the fallthrough is outside of the #endif.

https://lore.kernel.org/lkml/cover.1584040050.git.joe@perches.com/

Here is a delta patch for this.
Let me know if another form is needed.

 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index fc5236c..774048 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3702,8 +3702,8 @@ static int smu7_request_link_speed_change_before_state_change(
 		case PP_PCIEGen2:
 			if (0 == amdgpu_acpi_pcie_performance_request(hwmgr->adev, PCIE_PERF_REQ_GEN2, false))
 				break;
-#endif
 			fallthrough;
+#endif
 		default:
 			data->force_pcie_gen = smu7_get_current_pcie_speed(hwmgr);
 			break;
-- 
2.24.0


