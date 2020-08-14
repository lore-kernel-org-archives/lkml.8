Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE85C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209F220708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHNGHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:07:21 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:36584 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgHNGHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:07:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8B783180188BD;
        Fri, 14 Aug 2020 06:07:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shirt72_4110c3e26ffa
X-Filterd-Recvd-Size: 3581
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Aug 2020 06:07:17 +0000 (UTC)
Message-ID: <d1414df440b872ab7792946725991cb948537654.camel@perches.com>
Subject: Re: [PATCH] kexec: Delete an unnecessary comparison
From:   Joe Perches <joe@perches.com>
To:     Youling Tang <tangyouling@loongson.cn>,
        Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Aug 2020 23:07:16 -0700
In-Reply-To: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
References: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-13 at 20:45 +0800, Youling Tang wrote:
> Regardless of whether the ret value is zero or non-zero, the trajectory
> of the program execution is the same, so there is no need to compare.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 78c0837..3ad0ae2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -800,8 +800,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
>  						     digest, SHA256_DIGEST_SIZE, 0);
> -		if (ret)
> -			goto out_free_digest;
>  	}
>  
>  out_free_digest:

If you really want to change the function, then
you could change a couple of breaks to gotos,
remove multiple unnecessary tests, and unindent
a block of code too.

---
 kernel/kexec_file.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca40bef75a61..34a025e85887 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -763,7 +763,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
-			break;
+			goto out_free_digest;
 
 		/*
 		 * Assume rest of the buffer is filled with zero and
@@ -777,32 +777,26 @@ static int kexec_calculate_store_digests(struct kimage *image)
 				bytes = zero_buf_sz;
 			ret = crypto_shash_update(desc, zero_buf, bytes);
 			if (ret)
-				break;
+				goto out_free_digest;
 			nullsz -= bytes;
 		}
 
-		if (ret)
-			break;
-
 		sha_regions[j].start = ksegment->mem;
 		sha_regions[j].len = ksegment->memsz;
 		j++;
 	}
 
-	if (!ret) {
-		ret = crypto_shash_final(desc, digest);
-		if (ret)
-			goto out_free_digest;
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
-						     sha_regions, sha_region_sz, 0);
-		if (ret)
-			goto out_free_digest;
+	ret = crypto_shash_final(desc, digest);
+	if (ret)
+		goto out_free_digest;
 
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
-						     digest, SHA256_DIGEST_SIZE, 0);
-		if (ret)
-			goto out_free_digest;
-	}
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
+					     sha_regions, sha_region_sz, 0);
+	if (ret)
+		goto out_free_digest;
+
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
+					     digest, SHA256_DIGEST_SIZE, 0);
 
 out_free_digest:
 	kfree(digest);


