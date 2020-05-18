Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60579C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CD020829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6W8Z7f2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgERKdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:33:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32537 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726500AbgERKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589797984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkZd+ATLBaLYev6yToKjV1ATICAP4OZcw+kqfR8rbuw=;
        b=K6W8Z7f28YGkHY36qZ2Pa/64PH+Bsg6dUmSPk0YExsAlBQZ1yOhu3Oqe8NNgvMRntZxILi
        NqX9CYQixFr7bDSgsfdBD5hdKkvzHfiMJ/2tkVR7lJf5Iype8Tie5AEzS376o3WinTsR6M
        QvO3oW84ULmc4j8G7LmwEF3Q2thanPU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-qsx2yhhoNj-8xYwIYbgBFA-1; Mon, 18 May 2020 06:33:03 -0400
X-MC-Unique: qsx2yhhoNj-8xYwIYbgBFA-1
Received: by mail-wr1-f71.google.com with SMTP id e14so5452313wrv.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fkZd+ATLBaLYev6yToKjV1ATICAP4OZcw+kqfR8rbuw=;
        b=DOQTzeiGZNSaSwThn+WMKAVI4zjuCzVqbUf9J7vVHxkTV322aRtKTVerPwmFaot/N6
         6IQ22/33TyFrtFwDJslYvxt1/jmjjeDjkmwFgXzWt/eYii5HQLw01rLT70k9jY5Kwy6B
         tzHwWqAAGj0aCReC1sClxhZlGEgNd4V1twQMrfmr15VTplTA4FC+fs9DDahvVl3zi1r5
         0F3ESiXLFfpX5RwrN4VtCeoipZhWs1+nPJZFtHeo8yjidEYZWTjxp8k92j18DZZtqLJ5
         Dqfyu306dvTvgLmAAEe7VxPfs0ATatr9rWGRJkhIh5XIiToCwDniDHga4aED6b3FpA+B
         XHvQ==
X-Gm-Message-State: AOAM530xaYpwNixubdmjo0hb8eKwqYEvmG1JB9JV4i3N71EKUwmiLUQm
        o9+17lbUlGHW9HKyNP0srj08VY6/RwriosOBNowUZB4ocniH83KqQ0I3uoK9W3iF8VmbULSS0hw
        qH9wsYe3gRxPisdJGl6ezyxJU
X-Received: by 2002:adf:e4c2:: with SMTP id v2mr18711373wrm.72.1589797981965;
        Mon, 18 May 2020 03:33:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxaKQWu7YzReGiltWAyRl2hw4+e2C71C62VqLQpl2ItwOW1BspXytcsAQK4cMdA6ayUoHJxw==
X-Received: by 2002:adf:e4c2:: with SMTP id v2mr18711347wrm.72.1589797981753;
        Mon, 18 May 2020 03:33:01 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
        by smtp.gmail.com with ESMTPSA id e21sm15457996wme.34.2020.05.18.03.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 03:33:01 -0700 (PDT)
Subject: Re: [PATCH 4/5] rcuwait: Introduce rcuwait_active()
To:     Davidlohr Bueso <dave@stgolabs.net>, tglx@linutronix.de
Cc:     peterz@infradead.org, maz@kernel.org, bigeasy@linutronix.de,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        will@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20200424054837.5138-1-dave@stgolabs.net>
 <20200424054837.5138-5-dave@stgolabs.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57309494-58bf-a11e-e4ac-e669e6af22f2@redhat.com>
Date:   Mon, 18 May 2020 12:33:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424054837.5138-5-dave@stgolabs.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/20 07:48, Davidlohr Bueso wrote:
> +/*
> + * Note: this provides no serialization and, just as with waitqueues,
> + * requires care to estimate as to whether or not the wait is active.
> + */
> +static inline int rcuwait_active(struct rcuwait *w)
> +{
> +	return !!rcu_dereference(w->task);
> +}

This needs to be changed to rcu_access_pointer:


--------------- 8< -----------------
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] rcuwait: avoid lockdep splats from rcuwait_active()

rcuwait_active only returns whether w->task is not NULL.  This is 
exactly one of the usecases that are mentioned in the documentation
for rcu_access_pointer() where it is correct to bypass lockdep checks.

This avoids a splat from kvm_vcpu_on_spin().

Reported-by: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index c1414ce44abc..61c56cca95c4 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -31,7 +31,7 @@ static inline void rcuwait_init(struct rcuwait *w)
  */
 static inline int rcuwait_active(struct rcuwait *w)
 {
-	return !!rcu_dereference(w->task);
+	return !!rcu_access_pointer(w->task);
 }
 
 extern int rcuwait_wake_up(struct rcuwait *w);


Paolo

