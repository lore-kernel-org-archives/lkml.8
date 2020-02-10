Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D63C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5963420714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341503;
	bh=CCRdGqX/qGm69ug+v9Y5SR8BnRz4DNknCK4V/Tw2TAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=byBoZNaHBAeLPP3Q7+oaAAFmBTz3+O5zOCkZRqJxgbsoRr3OTN6s85I7s9RNc0jji
	 yCopaIVrEqlRzD6QF6V7FLSIbDgvxFBBjlXEeK0UJR+V8aPEeltz1bCk/5l0OUGkOT
	 b6jRPtzACkhiifKIbb4xANPEZ+xMxgvlNFXdiqr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbgBJNbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbgBJMf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:58 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E8D24650;
        Mon, 10 Feb 2020 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338158;
        bh=CCRdGqX/qGm69ug+v9Y5SR8BnRz4DNknCK4V/Tw2TAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRXWU+gTH/3WVv2i2j3AYws5aAS+jxbC/SESadO7rHP0+k+Qgh9ScmIlrWX53qPcd
         U2TSGjmXa1ulmBeXXWZxQjl0twjNYJ/KNI3qa8856pHHb9CRB4T3+lFSjQu/pDxp9R
         v1kcDysJfKUczFiRvC+LT0XGDqa7bfzkfoACyTTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerad Simpson <jbsimpson@gmail.com>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 088/195] dm crypt: fix benbi IV constructor crash if used in authenticated mode
Date:   Mon, 10 Feb 2020 04:32:26 -0800
Message-Id: <20200210122313.980830180@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <gmazyland@gmail.com>

commit 4ea9471fbd1addb25a4d269991dc724e200ca5b5 upstream.

If benbi IV is used in AEAD construction, for example:
  cryptsetup luksFormat <device> --cipher twofish-xts-benbi --key-size 512 --integrity=hmac-sha256
the constructor uses wrong skcipher function and crashes:

 BUG: kernel NULL pointer dereference, address: 00000014
 ...
 EIP: crypt_iv_benbi_ctr+0x15/0x70 [dm_crypt]
 Call Trace:
  ? crypt_subkey_size+0x20/0x20 [dm_crypt]
  crypt_ctr+0x567/0xfc0 [dm_crypt]
  dm_table_add_target+0x15f/0x340 [dm_mod]

Fix this by properly using crypt_aead_blocksize() in this case.

Fixes: ef43aa38063a6 ("dm crypt: add cryptographic data integrity protection (authenticated encryption)")
Cc: stable@vger.kernel.org # v4.12+
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=941051
Reported-by: Jerad Simpson <jbsimpson@gmail.com>
Signed-off-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -482,8 +482,14 @@ static int crypt_iv_essiv_gen(struct cry
 static int crypt_iv_benbi_ctr(struct crypt_config *cc, struct dm_target *ti,
 			      const char *opts)
 {
-	unsigned bs = crypto_skcipher_blocksize(any_tfm(cc));
-	int log = ilog2(bs);
+	unsigned bs;
+	int log;
+
+	if (test_bit(CRYPT_MODE_INTEGRITY_AEAD, &cc->cipher_flags))
+		bs = crypto_aead_blocksize(any_tfm_aead(cc));
+	else
+		bs = crypto_skcipher_blocksize(any_tfm(cc));
+	log = ilog2(bs);
 
 	/* we need to calculate how far we must shift the sector count
 	 * to get the cipher block count, we use this shift in _gen */


