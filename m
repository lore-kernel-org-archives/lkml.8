Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CF6C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAAE2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845112;
	bh=T0KW9LhRfqGeqUX6Km1CbTFGh3EnAJFz/LNoIML+vzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ze8HrHn3vdiv23sUKQM2m9vrl0Vtoc9BXnQ1Z9xp8VpXyiH3ekA0/43ZcBJ4ir8dG
	 q+Tv9yeYPabJHHedhoxMkeXu770Mg+HvsJMgvnkSY2WLiI5fpPL7r9lgfNqgWFH6Jm
	 Lx+X9wV1mReKeVZynFyCDQ3jlj9Zq9IUjjtnxGpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgCJM6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbgCJM61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:58:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A552467D;
        Tue, 10 Mar 2020 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845106;
        bh=T0KW9LhRfqGeqUX6Km1CbTFGh3EnAJFz/LNoIML+vzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVQajL9OL/oLURImn2EzOEjoTFA0HR3f0jgsDLDB7ujJra6ayEVdCvxm/pHZyXRd9
         ajxgShAk9HyfNXX51egYLR6sI7DKEYwcC6fFZ7U16PcIyq0VTb866DZa47NWFU9fCD
         r+TrWHMW2lB5T6aNpoaiTKdQQsLTu+oNK9D5uFO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 063/189] ALSA: hda/realtek - Fix a regression for mute led on Lenovo Carbon X1
Date:   Tue, 10 Mar 2020 13:38:20 +0100
Message-Id: <20200310123645.968154152@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit c37c0ab029569a75fd180edb03d411e7a28a936f upstream.

Need to chain the THINKPAD_ACPI, otherwise the mute led will not
work.

Fixes: d2cd795c4ece ("ALSA: hda - fixup for the bass speaker on Lenovo Carbon X1 7th gen")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20200219052306.24935-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6684,6 +6684,8 @@ static const struct hda_fixup alc269_fix
 	[ALC285_FIXUP_SPEAKER2_TO_DAC1] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
 	},
 	[ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER] = {
 		.type = HDA_FIXUP_PINS,


