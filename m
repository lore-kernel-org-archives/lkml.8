Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6A1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281BD20FC3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591637485;
	bh=HdKXL1KWhuaDB1oIJPo3MB7HfqNQoT0UtyHAQ5jTI9w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DbMCrP5WQLKzgHHb3mZYDj+zH/UumIdYEdv7M6tLJsW8IbkUi/yKycrEkS47mN4Fg
	 RpObPUVxZt3pgj92GqpURUXqkhQAEaO/S/N/Xyw3F001AATYUPJHy4EBGN1pSJeNJS
	 LfcMiAFIjB4EETJzchAxACiZDvPr4KOxkvpVnM8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgFHRbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgFHRbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:31:23 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D21320870;
        Mon,  8 Jun 2020 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591637482;
        bh=HdKXL1KWhuaDB1oIJPo3MB7HfqNQoT0UtyHAQ5jTI9w=;
        h=Date:From:To:Cc:Subject:From;
        b=AxT4QFYjCKHP4os4dIvfLdE/TXL1K+aFwGA6Du3BMPEi8PgGxIaIhlVuPfs4MW094
         x3gto+oAhabIu3+XDFLa8Drp655rIc7pzTF1rAHuZ8MfsDid5JfwshvyX9dZGnSpS9
         MPZSwYyrWh7JI1iWXn9AExBxOtabogFJ7HlBxzrs=
Date:   Mon, 8 Jun 2020 12:36:32 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] nios2: signal: Mark expected switch fall-through
Message-ID: <20200608173632.GA31741@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

Fix the following warning through the use of the new the new
pseudo-keyword fallthrough;

arch/nios2/kernel/signal.c:254:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  254 |    restart = -2;
      |    ~~~~~~~~^~~~
arch/nios2/kernel/signal.c:255:3: note: here
  255 |   case ERESTARTNOHAND:
      |   ^~~~

Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/nios2/kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
index a42dd09c65783..d8a087cf2b424 100644
--- a/arch/nios2/kernel/signal.c
+++ b/arch/nios2/kernel/signal.c
@@ -252,6 +252,7 @@ static int do_signal(struct pt_regs *regs)
 		switch (retval) {
 		case ERESTART_RESTARTBLOCK:
 			restart = -2;
+			fallthrough;
 		case ERESTARTNOHAND:
 		case ERESTARTSYS:
 		case ERESTARTNOINTR:
-- 
2.27.0

