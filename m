Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7051E20706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgFVLfh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:35:37 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:9331 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgFVLfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:35:37 -0400
Received: from sogo13.sd4.0x35.net (sogo13.sd4.0x35.net [10.200.201.63])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPA id 9ECAC240006
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:35:35 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
To:     linux-kernel@vger.kernel.org
User-Agent: SOGoMail 4.3.0
MIME-Version: 1.0
Date:   Mon, 22 Jun 2020 13:35:35 +0200
Subject: Writing to a const =?utf-8?q?pointer=3A?= is this supposed to 
 =?utf-8?q?happen=3F?=
Message-ID: <3986-5ef09780-43-189d6180@550955>
X-Forward: 127.0.0.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file drivers/usb/core/quirks.c, I noticed a couple of odd things about the function "quirks_param_set", and I'd like to check whether those are ok according to the kernel programming practices. Here are the relevant lines from the function (several lines omitted):

	static int quirks_param_set(const char *val, const struct kernel_param *kp) {
		char *p, *field;
		for (i = 0, p = (char *)val; p && *p;) {
			field = strsep(&p, ":");
			if (!field)
				break;

In here a const pointer *val is cast into a non-const pointer and then written to by the function strsep, which replaces the first occurrence of the ':' token by a null-byte. Is this allowed?

On a minor side note, this function immediately checks whether the first call to strsep(&p, ":") returned a nullpointer. From what I can learn from the documentation, strsep always returns what *&p was when the strsep was called, and p is verified to be nonzero in the loop condition right before the call to strsep. Is this check actually necessary? Is it a good idea to add a return-value check anyway even if it is not necessary, as an abundance of caution?

