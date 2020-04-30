Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE3C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A732070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fiRnfsbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgD3QcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:32:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56153 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgD3QcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:32:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200430163218euoutp01a99973ce088073c6bd46ea435de768c1~KpgBEMWW72458824588euoutp01U
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 16:32:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200430163218euoutp01a99973ce088073c6bd46ea435de768c1~KpgBEMWW72458824588euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588264338;
        bh=7QE3VHZ7MPCtYt13bWDgB4+62v21P5g7HbzKzNmuRs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiRnfsbhvflbPEU3Y/0VHe1k11ThcpeuT1K7eAK0GAMqetMS5882tXLqC1cDnsFPs
         aKIGVVxUu5idQ7pq9rQJPlsaz1gknUANVW7DjU+EL41DE7BffViOxSKedeFuYiDoL5
         BCOnf0VzDgGE3iv3sYPqPxP/hbg970Kng4hVwOVA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200430163218eucas1p27b766f65eec97aabce6a69a69fd47637~KpgAuUttp1131211312eucas1p2x;
        Thu, 30 Apr 2020 16:32:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 25.6A.60698.29DFAAE5; Thu, 30
        Apr 2020 17:32:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200430163218eucas1p1e89bdacc1cb8f1819d72cd789e972648~KpgAc8rwl1989019890eucas1p16;
        Thu, 30 Apr 2020 16:32:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200430163218eusmtrp20c91cf7ccc4c38135b833571ced7e676~KpgAcUP3F1116911169eusmtrp2k;
        Thu, 30 Apr 2020 16:32:18 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-66-5eaafd923f45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.BB.07950.19DFAAE5; Thu, 30
        Apr 2020 17:32:17 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200430163217eusmtip28cd53c2abd3f287d82030a9d6a4357cb~KpgAP6wNa1765417654eusmtip2Y;
        Thu, 30 Apr 2020 16:32:17 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 2/2] x86: kexec_file: print appropriate variable
Date:   Thu, 30 Apr 2020 18:31:42 +0200
Message-Id: <20200430163142.27282-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200430163142.27282-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHee7brubsuiQPZkXDPii4NCOeMEqpDzcS6kv0Qmqzbiq+VLup
        GZlmL5aaykZvajZLm0zJmmWmNmNFmpLiqi3LqFhhRq/OaopZzmvkt985z//8z//Aw5KK97Q/
        m5S2X9CkqVOUjCfV9HC0N0T72xgbWtbmjTvszTSu+tRFY+f1CQZ/vVqE8Nkbfvi12UDgfkst
        wiaHjcZPWioYXGPvI7D1np7A4+2jFG40nSGx7YWZwUPfOynsuu6gIzn+1/Fiiq+vrEe8yXiK
        4QdsbQz/padHxr+xNFJ8Y3UO/9X8jOGLbxoR7zQt4DuPjdAbZ23zXLlLSEnKEDRLVu3wTNTn
        NRB7P3AHvjUUolxU6V2APFjglkHv41KmAHmyCq4WwYWKYZlUjCDoqWynpcKJQPdSNyljp0YG
        r4RKfQOCd7Z8JBWDCAyvtDK3L8NFQUlNJ+1mX66fgPP6SDeTnJaAWl2gm+dwa6CypJVxM8Ut
        hhHnRcLNci4CHKPjjJRvIZQf6Z5iD24l1NT1kZLGBx5deEe5eTYXDPV5dkryXwhHb5WT7kDA
        VbHgKr5NSqnXwlsdkjznwMeOmzKJA+DPnUuEJMkBnXa5NFqEoKnCRUmaCBjoGZs6nuSCoKFl
        idSOgoEvXdOj3vD8s4+UwBu0Teeml8rh5AmFpA6EayVt04b+cPpjLSpFyrIZt5TNyF/2f5ce
        kUbkJ6SLqQmCGJ4mZKpEdaqYnpag2rkn1YQmP1/3RMePZmQej7cgjkVKLzlrMsYqaHWGmJVq
        QcCSSl/525jJlnyXOuugoNkTp0lPEUQLmsdSSj95+OWhGAWXoN4vJAvCXkHz75VgPfxzkSw/
        bzB7fajjRlFB/P35hqw3E5kPymMzsxVal8rqc7dwbEX+1u2+iwKHkk/4dpH808Pl98e2BOSu
        e7VbZTPoN8cZF3Vk80HhquKfm5bOHR62Wu32ZDxxeeP8z9HOtu3qQyFiQl39e+thUmPeFxE6
        KzoAbWjeUO04sLrdK6xVJj5VUmKiOiyY1Ijqv8u2K0R4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7oT/66KM7i4yNLi+PUdrBYL35xi
        tfi84R+bxftlPYwW0zaKW9zft5zJ4uahFYwWmx5fY7W4vGsOm8XS6xeZLC4dWMBk8Wf/TxaL
        zZumMltcu7WPzeLlxxMsFj82PGZ1EPD43trH4rFm3hpGj02rOtk87lzbw+bx7tw5do8Hhzaz
        eGxeUu/xft9VNo++LasYPT5vkvM40fKFNYA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
        z9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jQdN6poIXAhUf1nczNjDO4+ti5OCQEDCReL7YoIuR
        i0NIYCmjxP/731kh4lISK+emdzFyApnCEn+udbFB1DxllPi5eCYrSIJNwFGif+kJVpCEiMBj
        Jomln3aDOcwC05gkDk9bywxSJSzgLDGvfzcbiM0ioCrx5fNcJhCbV8Ba4vHPP2wQK+QlZjee
        BrM5BWwklq6+CNYrJJArMWnPNGaIekGJkzOfsIBcxyygLrF+nhBImF9AS2JN03UWEJsZaEzz
        1tnMExiFZiHpmIXQMQtJ1QJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiBsb7t2M8tOxi7
        3gUfYhTgYFTi4eXYtCpOiDWxrLgy9xCjBAezkgjvw1igEG9KYmVValF+fFFpTmrxIUZToDcn
        MkuJJucD01BeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGwn+1
        roWWrWb9wSU5ZTxfQ76l3eq3+GgZPJuB58vOpfp3fd5de7JYnN392FrmT8z32k7WulS5KQlN
        2/Oi7v9lrUatncdZalvERbTOT5Xb4mJ1+5kj37Pn96w/HvIwFbrpkD5B+pzIRjnz5KMip7On
        Kkjt+LvEMTlL6rDo9tWuJVN+xc4LTv+jxFKckWioxVxUnAgABN726wsDAAA=
X-CMS-MailID: 20200430163218eucas1p1e89bdacc1cb8f1819d72cd789e972648
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200430163218eucas1p1e89bdacc1cb8f1819d72cd789e972648
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200430163218eucas1p1e89bdacc1cb8f1819d72cd789e972648
References: <20200430105034.17513-1-l.stelmach@samsung.com>
        <20200430163142.27282-1-l.stelmach@samsung.com>
        <CGME20200430163218eucas1p1e89bdacc1cb8f1819d72cd789e972648@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of kbuf->memsz may be different than kbuf->bufsz after calling
kexec_add_buffer(). Hence both values should be logged.

Fixes: ec2b9bfaac44e ("kexec_file: Change kexec_add_buffer to take kexec_buf as argument.")
Fixes: 27f48d3e633be ("kexec-bzImage64: support for loading bzImage using 64bit entry")
Fixes: dd5f726076cc7 ("kexec: support for kexec on panic using new system call")
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/x86/kernel/crash.c           | 2 +-
 arch/x86/kernel/kexec-bzimage64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fd87b59452a3..d408e5b536fa 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -420,7 +420,7 @@ int crash_load_segments(struct kimage *image)
 	}
 	image->arch.elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->arch.elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->arch.elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	return ret;
 }
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index db6578d45157..420393c58a73 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -434,7 +434,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		goto out_free_params;
 	bootparam_load_addr = kbuf.mem;
 	pr_debug("Loaded boot_param, command line and misc at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 bootparam_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 bootparam_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	/* Load kernel */
 	kbuf.buffer = kernel + kern16_size;
@@ -464,7 +464,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		initrd_load_addr = kbuf.mem;
 
 		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-				initrd_load_addr, initrd_len, initrd_len);
+				initrd_load_addr, kbuf.bufsz, kbuf.memsz);
 
 		setup_initrd(params, initrd_load_addr, initrd_len);
 	}
-- 
2.25.0

