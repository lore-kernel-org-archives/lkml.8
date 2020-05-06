Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B37C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BFA206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myJHeLrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgEFGhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgEFGhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:37:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22737C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 23:37:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so516872pfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rIPn6skz9+CHSHwUFC2MWOYr0F1v/VhKVMihvs/Yn2I=;
        b=myJHeLrNnuX96MEy+Ht1sxEO3nat0eNyp43GrBz1UV9or6MePLmuXspff6fNrPOJli
         uaK7UDE9CELgO8T/n5hweWcOYGQlVJ2W1VjGpdfHBkXxBe/hhMFvP3b9brncj9jg66QT
         vgfvN6ZqDxY0+/eEuZbi+pAEU9tK091NnoRaafqNwVwLRefKGtImCAbehEmqeV0oUXha
         5CDa6BnJFZ/GVtthtpc18kqa2XdMM7r9yL2Avgmev8hhJSobCgjMFvE/yeLyiN9hF4UP
         ucCDWVEECvfkpCKsmuI+dD5okt+9dWJUGmcsFAf/wE6/Lh02xbg5XdDDxmNIz5JWbA0B
         fDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rIPn6skz9+CHSHwUFC2MWOYr0F1v/VhKVMihvs/Yn2I=;
        b=WzPynWlA0ETv3Gi19nZI53XUOt/eK0daCSHlumWt8xAFZaSZjnB1tVCotL2JQAvPTS
         edpYIxMdOYN/RRuLzkXf96hfw1ndQ39FcPOewSxGz3ng3Fuvmxueux1g8wbMF4gw/MB7
         qUroL9rxlckFDE+yBsfYZL8lmCmiUQM3NAETWU2OUifusZV0QiGfVAxERLWE9R5ASQaS
         28zj7PBNnmFo/3JzU4Xa2rgphkSGY0OotvP8qIrG7ObnqEiNNWIdygoYPIF/F9BlOrEm
         u7BKK16POakFPZfhkdqcRIGaXMrHc+mmLgTOauWrN7d9Ac2EnjfUqmMl+YDXhGofHzGn
         UW3Q==
X-Gm-Message-State: AGi0Puavq0SmWXrm8aXgN/wuanLtrxMl3AA+W3/I45V2yTg3HERqNKX5
        KL2ZyTntu6QLbtZhzwbhI5Q=
X-Google-Smtp-Source: APiQypJEf/R2iKSuVCdwxeAuyZgpQKI7r0/Np98az14Yv13VQZPHyObMBygThGu1TSCu5L7uaNH+3A==
X-Received: by 2002:aa7:9811:: with SMTP id e17mr6476248pfl.70.1588747043563;
        Tue, 05 May 2020 23:37:23 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id y63sm773289pfg.138.2020.05.05.23.37.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 23:37:23 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, alexandre.torgue@st.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/panel: Add Ilitek ILI9341 driver 
Date:   Wed,  6 May 2020 14:37:16 +0800
Message-Id: <1588747037-31198-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add drm panel driver ilitek ili9341 , based on panel/panel-ilitek-ili9322.c
currently just support rgb input only
