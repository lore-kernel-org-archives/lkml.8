Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3EEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD6520675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846926;
	bh=Cg/CqJDhL5vBLVPwq3kwxrK1hEijNk3vd2jgYBFSC7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EZrd4ywomX9Hzxgv/MxRXR08pxvDX8DmBLBFj8oAYfsPJReuIYSJWpwrRoZKEXJf9
	 j+j5gzYdSar2igzKD3YEJqLR0T6jKujkaR+ysFoBkIYAC6MEp0pUsEOBx1nqQq9Bem
	 ZH1J/c/ZuJVeuZ0Rp948esb9NrAs4WC3ZdRUJOic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgCJN2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgCJMxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B51720674;
        Tue, 10 Mar 2020 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844789;
        bh=Cg/CqJDhL5vBLVPwq3kwxrK1hEijNk3vd2jgYBFSC7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnmN55uk5bhQTSF9X0brXJenD/PF7oa22+DUOfCKEqfRUFKfBHavt+qLv4ftTkh+2
         fUi9D+qnjmZmczH8zbWtsARlj/vU21qWDQ+ly9REPxXbLo+BUob5JRo//O0yjxwL7j
         NSMo/eK/m47Kx86SbzlhGEBiHr50akYb4s44mBEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 120/168] ASoC: intel: skl: Fix pin debug prints
Date:   Tue, 10 Mar 2020 13:39:26 +0100
Message-Id: <20200310123647.572678362@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 64bbacc5f08c01954890981c63de744df1f29a30 upstream.

skl_print_pins() loops over all given pins but it overwrites the text
at the very same position while increasing the returned length.
Fix this to show the all pin contents properly.

Fixes: d14700a01f91 ("ASoC: Intel: Skylake: Debugfs facility to dump module config")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20200218111737.14193-2-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/skylake/skl-debug.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -34,7 +34,7 @@ static ssize_t skl_print_pins(struct skl
 	int i;
 	ssize_t ret = 0;
 
-	for (i = 0; i < max_pin; i++)
+	for (i = 0; i < max_pin; i++) {
 		ret += snprintf(buf + size, MOD_BUF - size,
 				"%s %d\n\tModule %d\n\tInstance %d\n\t"
 				"In-used %s\n\tType %s\n"
@@ -45,6 +45,8 @@ static ssize_t skl_print_pins(struct skl
 				m_pin[i].in_use ? "Used" : "Unused",
 				m_pin[i].is_dynamic ? "Dynamic" : "Static",
 				m_pin[i].pin_state, i);
+		size += ret;
+	}
 	return ret;
 }
 


