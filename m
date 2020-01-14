Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_GREY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54282C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275B124673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akorzy-com.20150623.gappssmtp.com header.i=@akorzy-com.20150623.gappssmtp.com header.b="HoP5G4vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgANLOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:14:47 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36162 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:14:46 -0500
Received: by mail-oi1-f171.google.com with SMTP id c16so11446412oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 03:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=akorzy-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ax3PVwosdQPDm4oypRYY3rAUNrnqWJKDsiet5NcHnN4=;
        b=HoP5G4vyWFCSjPGSGa4TW/xzyS95/o5m1v9WFONFvXaVD+ajm4lRHzq6b8peHIki7t
         cZsu7G3fW0FKLvEUVCEiQQxGjT5zr5Q8k3rfrOH0rUyO5UuqVn4g2bGMEyqR4GD8SeoE
         gmB/I4UURAII6hXunqUWLKsXhKhcgKrfuIqBKsbljgKSsTfvGHXObXEmQEfeGQHv4HOi
         SWapg/Rz610VkvKgxve3vRAw5U2qwiuZMrEp9Txaw1VRiwEleSZhiqZ+Hbspw6opBza+
         paD2YkugJkjqJOFvvPqwkM02REeqWkbcILjEkVQmFkBXxAsFmAm0oTduL1boRREGDs1c
         3Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ax3PVwosdQPDm4oypRYY3rAUNrnqWJKDsiet5NcHnN4=;
        b=UJVxEM30eEbb3+2mk3uLCJl3QJ3iKyCMayAug9+Lp6NU1gRC3+G/MqFkO4h6aW4Ref
         oVhskmpmcs9jXsH+WxVDH0R5JqReB7D+HXx6GWDZpx6ZYb8iVU2WSoPg/GwOeuxX7zDu
         2Dp8kg3joLogDLdpUfaSgWUPhdeElXEWzfSH+Ngik/vWFjm0l0h6Y2ouip1kSyUKeBPM
         OdQ6OVmyPfk8XJ7Yn47RKixqNJ2ZXwdNPXZiw49/NVgBIIx/BOvPBEtiOYnSMaRCqcu1
         2OII3zCNW54gag1EsrZVwPH7Dqk2UIjM226Quxc7XbInWo1js5FBz0l6MHBDs2iQnBk9
         UXEA==
X-Gm-Message-State: APjAAAXVFkB0LRL7eMjw5tawgvb9ykTRjtncbnAg88oI+GPKh56HNzmv
        aX50EJsnfqbwh7QGI6Ujz/DLN98vMTU=
X-Google-Smtp-Source: APXvYqwgMmFrDnDoPc8fVNQb7Wl47fB38xEk28p5hjL0b/FDSbth1xWj4TSpN3I+7Dp3M645Rwz1QQ==
X-Received: by 2002:aca:f1c6:: with SMTP id p189mr16775136oih.159.1579000485801;
        Tue, 14 Jan 2020 03:14:45 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id h1sm5298201otn.6.2020.01.14.03.14.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 03:14:45 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id p125so11400229oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 03:14:45 -0800 (PST)
X-Received: by 2002:aca:2118:: with SMTP id 24mr16280185oiz.28.1579000484653;
 Tue, 14 Jan 2020 03:14:44 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.com>
Date:   Tue, 14 Jan 2020 12:14:37 +0100
X-Gmail-Original-Message-ID: <CADWu+UnJ7N=U7s98274Hn3VrtXgFQoiPbsze4xm9GsK66Hd7Aw@mail.gmail.com>
Message-ID: <CADWu+UnJ7N=U7s98274Hn3VrtXgFQoiPbsze4xm9GsK66Hd7Aw@mail.gmail.com>
Subject: Survey results: "open source" vs "free software" vs alternatives
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I conducted a survey of about a 100 US consumers, asking them which
term they prefer to describe FOSS. The results are quite interesting.

The respondents are not necessarily computer engineers, but rather a
representative sample of the general US consumer public. They were
given a predefined set of answer choices, which included the
well-established terms, as well as some new ones, that I haven't seen
used anywhere. They could choose multiple answers.

The clear winner is "open-source software" with 49% of respondents
selecting the term. It's followed by three new terms: "community-owned
software", "community-developed software" and "communal software",
obtaining 32%, 29% and 26% of votes respectively. They're then
followed by the neutral term "free and open-source software",
receiving 24% of the vote. This is followed by the new term
"commonhold software", receiving over 15% of the vote. The classic
term "free software" was selected by 9.6% of the respondents. It's
followed by the alternatives "software libre" and "freedom-respecting
software", each one receiving 7.7% of the vote. The least popular
choice was "free/libre software", selected only by 2.9% of the
respondents.

Unsuprisingly, the term "open-source software" is preferred by the
public, although it's not clear if it's due to the attractiveness of
the term itself or due to the widespread usage of the term. The
greatest surprise is the high score of the new terms "community-owned
software", "community-developed software", "communal software" and, to
a lesser extent, "commonhold software". I wonder if they would score
higher if they were in widespread usage. The neutral term "free and
open-source software" is also acceptable to the public. The relatively
low score of the term "free software" may be a disappointment to some.
Its alternatives "software libre" and "freedom-respecting software"
scored only a little lower, which suggests they are reasonable
alternatives, but another survey on a larger sample may shed more
light on the acceptability of these terms to the public. The term
"free/libre software" is clearly disliked by the public.

Thoughts and comments?

The question asked to the respondents was:

> What term would you use for computer software that any user can freely modify and share with their friends? In other words, software controlled by the general public. You can select more than one answer - please pick all the answers you like.

The results are as follows:

Answer Choices                 Responses Percentage

open-source software           51        49.04%
community-owned software       33        31.73%
community-developed software   30        28.85%
communal software              27        25.96%
free and open-source software  25        24.04%
commonhold software            16        15.38%
free software                  10         9.62%
software libre                  8         7.69%
freedom-respecting software     8         7.69%
free/libre software             3         2.88%

Total Respondents: 104
Dated: November 2019

The survey panel of US consumers was provided by an independent contractor.

Full results:
https://www.surveymonkey.com/results/SM-C822DGTW7/

Best regards,
Aleksander Korzynski
