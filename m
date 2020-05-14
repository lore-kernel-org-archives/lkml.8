Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FAFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AD320671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE86Yvyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgENOGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:06:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44321 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgENOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589465160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbY83E69uffAESaWml+T0AXcFZ6rmqCOkFWMnK8Nufs=;
        b=bE86YvyfZvtUCPkzAdLoxdk4poU67w0zrR+nhpvgnNTiOFGAPkXR7K4GylpCwTJHG0tovd
        r26yCRpPZans0fpd1zLlLjfWeJ97VOvX6Cyvj0sQR9RBesGbxCRpz2Iu9gcKB1a2SqTtrW
        Nm5VPRKM0I0Ecw+odcfqxGOQ+FzGypA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-JnYc5_S1P5WlPb0cZcqGqA-1; Thu, 14 May 2020 10:05:57 -0400
X-MC-Unique: JnYc5_S1P5WlPb0cZcqGqA-1
Received: by mail-qt1-f200.google.com with SMTP id e44so3648229qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbY83E69uffAESaWml+T0AXcFZ6rmqCOkFWMnK8Nufs=;
        b=Pkx1DdPnzGcBs9pYGsRwTP8Au0NK/Ynyjhqt/2waUbf0Z3aAxrM/DQA/xj3r+CarVJ
         d4Kbx6VubXgf+gUonOS5WUTnThLu94uhjVIICmsQsb0dXquqYiH/4fLkDt+7GQTQdKFq
         Re6kEbOmwIiRbbsdvF3SzmmomieJVamvymAKv4BzOub3W+s9xhPV2BQ3NPagL8diFtCz
         H0Dor2ezZH8f05dAxEI5lFlnUNHweoD0mWq6BLiP2uXyD5vRzlqY4Z10GwZ5vY11hiaC
         JSyAFuOb5WWpe8q+p7ravu5qkSo12or1cKAcyqreaBSYHkplUE2IfaBhc17Dmg7YSECW
         Rmvg==
X-Gm-Message-State: AOAM531MtiknxvmgypqNxzPYuQjBZHWnpWAVwAMDt6/VE447L6eglqCw
        xxR8RrLoFh9obp9VWz4vNiHRebZCkk96ysoNcWKrWMDBAqMH32jlTdfR9Lcn3syy9fxwj8z+XTD
        j3zZC4q8W3tbaoFVTBQJgSuIt
X-Received: by 2002:a05:620a:4c9:: with SMTP id 9mr4749672qks.487.1589465156872;
        Thu, 14 May 2020 07:05:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo2fADFfavryjF15PayRQMc7FxwNus8UzpkWG2jA0/z5miZ85649I/y0hblRMmuuaFVkmfuQ==
X-Received: by 2002:a05:620a:4c9:: with SMTP id 9mr4749650qks.487.1589465156577;
        Thu, 14 May 2020 07:05:56 -0700 (PDT)
Received: from dev.jcline.org.com ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id z65sm2536791qkc.91.2020.05.14.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 07:05:55 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        "Frank Ch . Eigler" <fche@redhat.com>
Subject: [PATCH RESEND] lockdown: Allow unprivileged users to see lockdown status
Date:   Thu, 14 May 2020 10:05:46 -0400
Message-Id: <20200514140546.826698-1-jcline@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200220151738.1492852-1-jcline@redhat.com>
References: <20200220151738.1492852-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of userspace tools, such as systemtap, need a way to see the
current lockdown state so they can gracefully deal with the kernel being
locked down. The state is already exposed in
/sys/kernel/security/lockdown, but is only readable by root. Adjust the
permissions so unprivileged users can read the state.

Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
Cc: Frank Ch. Eigler <fche@redhat.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5a952617a0eba..87cbdc64d272c 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -150,7 +150,7 @@ static int __init lockdown_secfs_init(void)
 {
 	struct dentry *dentry;
 
-	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
 					&lockdown_ops);
 	return PTR_ERR_OR_ZERO(dentry);
 }
-- 
2.26.2

