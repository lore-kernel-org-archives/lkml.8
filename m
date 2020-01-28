Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4A1C32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E602467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580174927;
	bh=Zds4NOwLTCDcIdvIHPsXpWqNcvbYqSU61DLA9ocvOpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f4g+xgX+IQiH3jfxjQUVwIxtIrYh4xRenZ/5b/xr2bITgOG/QWvGWZT+td5s1XTLu
	 nxzzhzUa4QJsRhfcZGI5SElfZv0TUoSj9pAPmR5x6zShtwocQHLI5Z538ZBKWBch30
	 1FPzVmCtlodh7yKEgwKQayc0Uc4sSeeswnQiWy2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA1B2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:28:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44788 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgA1B2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:28:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so7765515lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 17:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyg3NKEp2bxr484Sg68cndy6raZFMZTA4yF4ZhQs6xQ=;
        b=ZwZCZIO0IYyYHGyUd4fQxgAHJdpemFwJyBRh1bLDPf/Bg4kuctvr+23k1ufcDXh+rO
         YhacjuLMqf6owAn9magtEfwyFneJosD23UCjAsMEY8OCj2mNNtkv03tLOEY6YV9uAz0P
         Mof+NMLsFwiPZXulWXN6n9oGlUwtjLuKeL85U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyg3NKEp2bxr484Sg68cndy6raZFMZTA4yF4ZhQs6xQ=;
        b=SqBrVNY+2mUafLUIpOTgt5aNAptwwzAj27pLaWfbulWu18WYb8KPTEypATCEFvHEzO
         H8ootcQa4J0VSx5YcGSNkQClxxY0l2aHppTSpGoGVoPnu6ttCZaIfhpa4urPN3bemquq
         MQRZyh8xC1if4CmHX5W3u+eljayJOHtm1CdKTrSNmzyAT6ThxsWe/mo6Mflz6Mtzxr7S
         3pQ2adlwOpgmxlpTnDLnROeNAMzviWW7h0lkgl6vnI3CFKNpf/qhdD9G51lE/EdylfkN
         H5FnEq50mp3wjXCg/CDpIXgfY6bKVPgPqRqjrYkgmHhnf6or4eJZDsNJbTkgQdaya3w3
         mqoA==
X-Gm-Message-State: APjAAAVq5btsd6MN/Fs5i56LV+ap6gBpJ+bKNLBzm+Yfh13HivSp/Gsb
        9KpdxVAeAIE/g1fgXKKAE9acZoKUKiA=
X-Google-Smtp-Source: APXvYqzyg3M6Au1CVS0jErRtwCWGfZppJT7LrjZCn3NjTtfsgzQaI7JtJl/jIEBDq7jhTjQMSOg7EA==
X-Received: by 2002:a19:f80a:: with SMTP id a10mr834173lff.107.1580174921482;
        Mon, 27 Jan 2020 17:28:41 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p26sm8906797lfh.64.2020.01.27.17.28.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 17:28:40 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id t23so7780423lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 17:28:40 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr825368lfb.31.1580174919818;
 Mon, 27 Jan 2020 17:28:39 -0800 (PST)
MIME-Version: 1.0
References: <3021e46f-d30b-f6c5-b1fc-81206a7d034b@web.de> <BYAPR04MB5816FB9844937D8A86B52F8DE70A0@BYAPR04MB5816.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5816FB9844937D8A86B52F8DE70A0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jan 2020 17:28:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whHZzyaRKu5WXTE7_mPaQPf-E-r=cZ+8YGVK5RPbzjt1g@mail.gmail.com>
Message-ID: <CAHk-=whHZzyaRKu5WXTE7_mPaQPf-E-r=cZ+8YGVK5RPbzjt1g@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 5:26 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> Yes, good catch. Furthermore, since this array is used only in
> zonefs_create_zgroup(), I moved its declaration on-stack in that function.

What?

Making it _local_ to that function makes sense, but not on stack.
Please keep it "static const char *[]" so that it isn't copied onto
the stack.

               Linus
