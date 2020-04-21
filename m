Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7872DC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4B720679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhsSdZ/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgDUOrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgDUOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:47:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA95FC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:47:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a22so1434274pjk.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REDanlIn51eutGNf5uVqUmrvAhwfniHOxSyexe3EO7o=;
        b=MhsSdZ/4Ernny2tfflH1JcnoiLoZ2DKPh4A5fhT5NpP4y71c1+QQIIvpnAM+gUA/Sk
         5r0fs3pLBBWtXfsrzta4fj7YurjuqhK3iG4tjw+6LW7lUWje82/NIvcXLCW5e8Ex8m3O
         Az7WrSFn3OE3CsAU+ui1uAUaiV9+Gyjc5hTJ0jOexnSF+c7CAwD5vs04NA//qYRVtr6S
         kVvCVxygQH0iXWuv+MstOWJVvPnUAfmj3pjXB7DkfS0q3BxtG6ipg9h5k9ZNmVor1c5G
         cH+9Z67oexE2YPOuQ0OlZmH0Tsv/uoV/HJuiV7AlIG2j1C4EbjcVq0aA1khF/b3j2mc+
         rbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REDanlIn51eutGNf5uVqUmrvAhwfniHOxSyexe3EO7o=;
        b=ZBOuAbN48iQ3GnIKH7mpx68NaCf/gbyy1m+jGIrIWv8LQmprGzmEZ4+qvDuAw7hBHu
         KvoFJLaEDS+m1aAi03x/O/JfP5/lOcEuzZE5q0r1NCP2x+lOtoCEmv7m31+JVdVJwz+c
         gNlyo8GAk+SOn05mkNUygffu7+v0hAQ+m3tOh591PiAS9t1nKHxwd8wMG3nIIZmbeXBj
         Vwi66xytrDnGPS7QWkqNxWf0bweU18QMO3hZI1QvB6nx4KUL9Wzlj6kvJTCVkwPuOSEU
         5X3fXSg1Qwj6MiLYU7SRi0VgvZsRaw6o+qE9haJqD3v1/fESjHZUFPSC0pW6RCdPQDae
         vcHQ==
X-Gm-Message-State: AGi0PuauQEVEhnzVVRCzuEmB/rD7gZ8F2pluDx+74Nv7xvI0ial5P4/G
        UziqUyMvuwfrFhwCEGVKkQM=
X-Google-Smtp-Source: APiQypKQa+TqQjd0MruXmB8XqNPgNGRN53IKCiUW8GNlKz6cdzaFtF+m/rMGX1T/HKSArVUZiNrVbQ==
X-Received: by 2002:a17:90a:730a:: with SMTP id m10mr6292027pjk.9.1587480465940;
        Tue, 21 Apr 2020 07:47:45 -0700 (PDT)
Received: from localhost.localdomain ([2408:821b:3c17:9da0:b0c4:dd31:5ddb:af0d])
        by smtp.gmail.com with ESMTPSA id q63sm2617337pfb.178.2020.04.21.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:47:45 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     peterz@infradead.org
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com,
        youling257 <youling257@gmail.com>
Subject: Re: [PATCH v3 14/26] objtool: Optimize read_sections()
Date:   Tue, 21 Apr 2020 22:47:14 +0800
Message-Id: <20200421144714.12479-1-youling257@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324160924.739153726@infradead.org>
References: <20200324160924.739153726@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch cause 64bit kernel build failed on 32bit userspace, please fix.
