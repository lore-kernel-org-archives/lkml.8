Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC39C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EAC218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581022034;
	bh=dLPRktdw/r9ySo6ztgytWzSFSOHllCAWY45zVysLi+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w4eVet6yGijkcAsL/aZV+FIacX456nueszPez3cA/2hUMkcrPXHl96sQUbbGWCZvQ
	 IlLp/pnCqpGIjOramuzTgSamiJQP6yhvI/SA0gA6ZWJc7kcbMKtcxyo1lyvgOvpEN5
	 KimLyeZwVzTZYnDd7uLEqLGg4c2U5C9N+CWOPXrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgBFUpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:45:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35119 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgBFUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:45:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id y73so60956pfg.2;
        Thu, 06 Feb 2020 12:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+5+zudFLEE54RFgGYNUhud7P5ykhS6QeS0Eeg6mrByQ=;
        b=FF3JRf8VMD/KZ/exI5b7luPx3w/x5cR6SJJdsW5MhM1ttMI86NLHmz9RUrYFkMJR+a
         ihGftiCMJlJPdYjWQtME2SJaKMvjygDs31eMTGC6xGSW99kpE33w9KRxhHy2Ld86jpdR
         DoiGkEN8Z8O/Xvxj+HCJYPVbhHIQo/Q5kYZl9KivV+2AhHbpmbrw561fdmylNut+quPY
         UPZPVnRw9m1eBZOPGWEEWxLU/Q3Bwuye8gMEkhjzGBRQc7EAeVGk9R5PMfBXwfl3BeeN
         qy+PzBv/JdLGeLhuI+fV4sYEG3eFWzW0hR9JYUTbdkihbK0nWUVgtPPiNQnTqD2ssH+t
         CpeA==
X-Gm-Message-State: APjAAAWgbHAoM3xd3TAQwOH2txUP2AtGLz/vLxpIuqwYQRrgkPqf6HLw
        lTAxzAeooaC/wY6OWR/6tA==
X-Google-Smtp-Source: APXvYqxx3xiy6suP140csN6jmTWRjdAkDcziJEtMyX+hlSDZ0vGdcdlTlihGnjZPFtNI/bKbll/9SA==
X-Received: by 2002:a63:e044:: with SMTP id n4mr5612914pgj.338.1581021942409;
        Thu, 06 Feb 2020 12:45:42 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id m12sm158298pjf.25.2020.02.06.12.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:45:41 -0800 (PST)
Received: (nullmailer pid 4349 invoked by uid 1000);
        Thu, 06 Feb 2020 18:35:33 -0000
Date:   Thu, 6 Feb 2020 18:35:33 +0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, a.hajda@samsung.com, narmstrong@baylibre.com,
        tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net
Subject: Re: [PATCH v4 1/2] dt-bindings: display: bridge: Add documentation
 for Toshiba tc358768
Message-ID: <20200206183533.GA4136@bogus>
References: <20200131111553.472-1-peter.ujfalusi@ti.com>
 <20200131111553.472-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131111553.472-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 13:15:52 +0200, Peter Ujfalusi wrote:
> TC358768/TC358778 is a Parallel RGB to MIPI DSI bridge.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../display/bridge/toshiba,tc358768.yaml      | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
