Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F248920707
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598922225;
	bh=XKSlaypy6l4cy6xRyhUggtwkZyk6umvYikrcCWWWMUY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=g3B9r1uqU2H5pcv687Cj/Ifband0WUqn1z0mBCP8jU1e3pZxxIpWk9hbTtZxb0/8l
	 /2SBeybHUVRWSRAZDrEqFcWHW0Den/eVyJYIQJTxxzoaKbU8bBUUPa5ekGANjrcMMD
	 6Qs5tl6p57Q6kV/Q5E/QfBUynz+cI0k6URBYduuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIABDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgIABDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:03:42 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6027920707;
        Tue,  1 Sep 2020 01:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598922221;
        bh=XKSlaypy6l4cy6xRyhUggtwkZyk6umvYikrcCWWWMUY=;
        h=Date:From:To:Cc:Subject:From;
        b=Gqm5vuG+x6r2t3nTWOYAIE4FU1WZUdt90aTCq7H7wilAI/Ck6h/DdboO20MjrNvOG
         msjWAX8TYHwc8z4MIbEwEnqcu7u63LB1mUrSfPWksHhvj/wWBn5zCzQfzwrM+jDGns
         ATpkDsEdW8eiIRk8t6uDN1P8ELo4cZvBNTmmv/Vw=
Date:   Mon, 31 Aug 2020 20:09:49 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] docs: deprecated.rst: Update zero-length/one-element arrays
 section
Message-ID: <20200901010949.GA21398@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update information in the zero-length and one-element arrays section
and illustrate how to make use of the new flex_array_size() helper,
together with struct_size() and a flexible-array member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 Documentation/process/deprecated.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 918e32d76fc4..9731704b3f3d 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -322,7 +322,8 @@ to allocate for a structure containing an array of this kind as a member::
 In the example above, we had to remember to calculate ``count - 1`` when using
 the struct_size() helper, otherwise we would have --unintentionally-- allocated
 memory for one too many ``items`` objects. The cleanest and least error-prone way
-to implement this is through the use of a `flexible array member`::
+to implement this is through the use of a `flexible array member`, together with
+struct_size() and flex_array_size() helpers::
 
         struct something {
                 size_t count;
@@ -334,5 +335,4 @@ to implement this is through the use of a `flexible array member`::
         instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
         instance->count = count;
 
-        size = sizeof(instance->items[0]) * instance->count;
-        memcpy(instance->items, source, size);
+        memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
-- 
2.27.0

