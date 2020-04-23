Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD899C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAFE20704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEZkOU/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgDWQTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728865AbgDWQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:19:36 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232EC09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:19:34 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id 36so2199244uaf.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKUcBuJDdde4mOEyRTnllxM+tu62ZA2QD/StkqYkuis=;
        b=NEZkOU/0uCz//ZqaAJkcGOCvpnUulQ02B0Ex143Mw3WV5xFZywAgbpsn9AzJ7InUxY
         Zf5lR349Qjg1BLHrT8/Ml2Dy6f5cx8S3x8blRTf1jq+qfs8o5P1fVeSb4vV4AEp4XTt0
         YG/2ldfM9aDW2SfHMjInfGXWq3VeIf5D866rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKUcBuJDdde4mOEyRTnllxM+tu62ZA2QD/StkqYkuis=;
        b=FirZuLFDwgbL5Z09RNHHdSUZoYBmFvs+bRIFXiBjnbXKFtMh3RV4Uf+7wD6JKUlY//
         D9aJGc1zLkam881Bj4PIFHHROgu9yJi3Gk/W0uBJMAl0UfCZjp8WfNLxsc6KvRRrnYFc
         lP+S/ss8gBAmtD+t5DKU2BNbVkWfi/vN03CZE+Zdef/5lh5I/fOQYpJfsgm6aeAMlRAe
         GClMUT0hEQqJYs+MS5Um9ihHQFHVhL8Hu8O1FkCXsm7X5saRi/5M3nUkKT8o+e2Pe86I
         SRMRMGG2yDg1dB9Zi0FW9Sueok+OybiGTNJ66kcubw7SpVOdbEo9PhVE2qNqx/N0fjWC
         M62w==
X-Gm-Message-State: AGi0PuaMELckwA9t7c1RO2HdKdIrXXnv0mjC0gpp7PtxC6J9JJzVWiyb
        76EccheHaYRCcwQVBbTbp4wgMj6CErk=
X-Google-Smtp-Source: APiQypLmUluzeP9eE1Kc+kLYXpvyE79/j0+Pq0cwz/HtJkM/22GdPYT+7vzm1C6p7GazLnuk+nmBhw==
X-Received: by 2002:ab0:704d:: with SMTP id v13mr3777903ual.132.1587658772870;
        Thu, 23 Apr 2020 09:19:32 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id f6sm713279ual.9.2020.04.23.09.19.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 09:19:32 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id i22so6266231uak.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:19:31 -0700 (PDT)
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr3971569vsp.198.1587658771501;
 Thu, 23 Apr 2020 09:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
 <7e060977-611e-abf5-af76-1cc91660a8ba@codeaurora.org>
In-Reply-To: <7e060977-611e-abf5-af76-1cc91660a8ba@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Apr 2020 09:19:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WC78xxDUCynbfX0rnAAUxJfUedNhoCrw=5UHhcrRFu8w@mail.gmail.com>
Message-ID: <CAD=FV=WC78xxDUCynbfX0rnAAUxJfUedNhoCrw=5UHhcrRFu8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] soc: qcom: rpmh-rsc: Corrently ignore
 CPU_CLUSTER_PM notifications
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 22, 2020 at 9:45 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> there is a typo in subject, Corrently to correctly.
> Other than this, fix seems good to me.
>
> Reviewed-by: Maulik Shah <mkshah@codeaurora.org>

Sigh.  My brian has never worked very well.  One of these days I'll
see if I can get it tuned up.  Unless there is another reason to spin
this series or I'm requested to, I'll assume that Bjron or Andy can
fix my typo in the subject when applying.

Thanks!

-Doug
