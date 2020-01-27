Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D23C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DFA24679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ai2eNXCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0UXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:23:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45634 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0UXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:23:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so10972174qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8qKqO01LjJEV2xvyFnaCmO2+7pGkQQVcqgngFOI0Bdg=;
        b=ai2eNXCfULQ9MIfNUuFSqGlNe1UjEeX7vW60s4LzStmubnbO2lXRJ7erZvzrftbU/D
         t7Af6knAjRi8ykaakXoT8ykGkFSj4yRgs87Y6sSKXFic6KZnBPbgYp8xygd0tofVRTqf
         RCik9aE3Jb3pv2RNkwlhY4DcmV/N7zanhAyfriSLr92w+nBAXxdC7HSLA1zuq/9ryxdZ
         Qg0TGIjf6abZH9a/Xbwsl5B9QlNKIa8GtkTcYIolvTmIthTTKR/z0Xe/yCA8hVR1Idh+
         5NIjzYGbhjTYE5ka+aLtUcuwKTTf2wv/I3oUZCV1B3P2HRbAoORmFY3XneMSQsUSMfo+
         PSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8qKqO01LjJEV2xvyFnaCmO2+7pGkQQVcqgngFOI0Bdg=;
        b=YK15un1bD4f6q2sCi1rHOMUmDFw+/Gix7raeAJEeMQ1knnjvQwMFNf+2tCJ5ovJADm
         Qd/pdXVjfqYEIQOMJNVnQ+vwJCQ88bDhSpETAj/PaR571cREoGim2vQKbTZ4KlgnBuz8
         AQSDmFsACsgKpDPd7mZWSq3vVvgrcGDVFjnueB+tqCuOR9scvh8OPinA19osoJWx59zg
         eLwuP2fJ5FbyKriSskItMo20sKBwp/gha/QBmfg5O7T3oTXhslSzhzubfzbC2OjHk1ni
         Qw4VjPXwKHf0xWCsFiZ64rGnsjOmfu/7R8cRnR7HqdivGzgX9QSoheA1yV2VWpG4hbF1
         h5Og==
X-Gm-Message-State: APjAAAUnGsd0twD0nTdv+7idmQJrYyfgA/KdAQADLvE3XBDeibW6iKPe
        QArxxzKJcE8dwwkboKc7yY82CJbPrTC09A==
X-Google-Smtp-Source: APXvYqyqwzq9ivF63rt/+NSgs5OiwHgE68E9GTg3XAmC8qmv9oon15bYYFEUopxowFGMR0UBU7Nzew==
X-Received: by 2002:a37:4dc1:: with SMTP id a184mr18702854qkb.62.1580156590526;
        Mon, 27 Jan 2020 12:23:10 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d20sm9039726qto.2.2020.01.27.12.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 12:23:09 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: mempolicy: use VM_BUG_ON_VMA in queue_pages_test_walk()
Date:   Mon, 27 Jan 2020 15:23:08 -0500
Message-Id: <89FF2013-1B59-4702-BF1B-A200C6785B37@lca.pw>
References: <d6c1a434-8670-97f4-345c-28c8007a25ce@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d6c1a434-8670-97f4-345c-28c8007a25ce@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 27, 2020, at 2:57 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>=20
> Dumping more information to help debugging. I don't run into related bug p=
ersonally.

This is a relatively weak justification for merging. If we are keeping accep=
ting those mindless debugging patches, the workload will be unbearable for a=
ll.=
