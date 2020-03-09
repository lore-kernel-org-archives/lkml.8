Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF9C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5783020675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3VbLfph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCIGz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 02:55:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40921 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgCIGz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 02:55:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id p2so8750253wrw.7;
        Sun, 08 Mar 2020 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dm/e7fVVkyUEJNRr/yTEUzT0xvOhNYWpgvQvhHUhF68=;
        b=s3VbLfphTDUMOj5VgEB+bJaxg9XNGT89jpF7/fzn4h2lZjtBN2yMNm+e2Mk1q3vVbz
         2hu8irwSULuWR6uM43Wv53RBYq6D8D2BBoG3YD6ovjl857cnhxhwjSTQ0PQTELIqogKQ
         /yyn6SfIz769wKub7xSny0zSlNeUbAq7qpI5RPwFPuVZ4IGqm67Sdov8lAwKUL+koX53
         5kYAbSbYqLJrm/u2YaUvrq24vjlONNNEgpvHIGRtuzx++/LgRQmjp0JJgmQAqtAdfLkJ
         YpY1lGAWis9ADEi+SJCUaE0woOUY9hR3uXmr8drGmY4IegRi4kKBxCRU8B6pzqkrVbkY
         uBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dm/e7fVVkyUEJNRr/yTEUzT0xvOhNYWpgvQvhHUhF68=;
        b=flupmVY/WlLFLVinH6cj+X5K7RqVOZGdU1noCvFgA23rs5k4ZQiKrwx3WO60xbuXKJ
         wa9VCOkSSUH3YGBQAqcWDTZZb/137F/cCBlrZ0Z9LBbkw/ZqY/qcZ95WPxRSN7ISG1o5
         287HbDYEfpbS9WfB34PXcRVERXuyA6xZxMUnK0mMGk9bJ+Fhd/l6ME09uqNnrBZNGvOA
         t8MNqXktCUPYQnTIVtnqn7kJcP4AEW2O96JXIOMrIcb61FA9o97HSsbcthvXuawwWRtn
         k/nmf+YrreANlmh2uMmz+DXjDQmue/8swH8V5xI8ju7XLsxNNXT6OJjMuOF2IHrwC0SP
         I3qA==
X-Gm-Message-State: ANhLgQ13NexyJXAnWbq1zqSzfuSffyOw6i2FwioJqwb+SnoFCdTNDUIb
        HLoBSQv6xeymx8pRC6aV+8I=
X-Google-Smtp-Source: ADFU+vuCkgUSr5KTXA5g4+RQ2G5B4vEX0HXc+ZOFzelH2n6p5QuIzylG840VCzpvNwVRkr+/89Abxw==
X-Received: by 2002:adf:80af:: with SMTP id 44mr19311433wrl.241.1583736925115;
        Sun, 08 Mar 2020 23:55:25 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l5sm24320597wml.3.2020.03.08.23.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 23:55:24 -0700 (PDT)
To:     jbx6244@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, heiko@sntech.de,
        hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org
References: <20200306170353.11393-1-jbx6244@gmail.com>
Subject: Re: [PATCH v1] dt-bindings: display: rockchip: convert rockchip vop
 bindings to yaml
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <590762ab-db79-c8b1-7f0e-b653ed4b1721@gmail.com>
Date:   Mon, 9 Mar 2020 07:55:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306170353.11393-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Question for robh:

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like:

assigned-clocks:
assigned-clock-rates:
power-domains:

Should we add or not?

Kind regards,

Johan

PS: Will drop 'rockchip,grf' in v2 for px30, not used in vop driver?
