Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8CEC0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73362074E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="TOS3dxr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbgCLATt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:19:49 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:42080 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbgCLATt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:19:49 -0400
Received: by mail-qk1-f180.google.com with SMTP id e11so4007367qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=MO+EQlWMy0kzz1J1x9/iOGY80QsD1Dxgz1zaFvELTUk=;
        b=TOS3dxr5Ig5VZh/pLdbhl97cPhAHs3l8lln+0ZfH48xYNyB1AiqddC4eiEzGqHacnK
         YWr5Xk4C8gBK+tqIT3tFAukZ+q1A5Fkp4BEDr48ygEUjJLwIQ+US1lHwE5quULAMggSA
         os3OHpxJ4IZBuMYoTj9fbKLfvnvPjeFUaa2HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MO+EQlWMy0kzz1J1x9/iOGY80QsD1Dxgz1zaFvELTUk=;
        b=EN++XBY4GonBDwBNDizBDhe5jfrgUQ3dSnII/JyuY0TcWlXlCh82G0AhG1ihcR6adS
         i3OW/4DcnKt9jkuXwTPaXpI01ixly82+zI3eVMMoAS/TYqlAnICTn0W2h/WUEQejNwKH
         IYanJr6Nnbgw+mabIzv600PqiEJZE0B/ZCTxaymqW367b7xfAy1FVl78rfJQ0EOUmdUs
         A8GxGSWeKYEiA9dn5r3IphwNAfC2ypxGd3eFKPM/RC7HQEqC9Rx0FSTdGFSFPaeeer+j
         gNE2ievwmSKsz2mzDzi/53PfZrPWCo4Algf2Bb+EOIff9SsRpuh7sfWGBkgF3nuW6t3/
         ykVg==
X-Gm-Message-State: ANhLgQ2RLUbXptWs37BlboVvw53jtZ3IlKBxXvE68B92JYLRVd8hs23a
        GRG8QD2XdMQ8ioqBUCGJNjK2Elg6OEU=
X-Google-Smtp-Source: ADFU+vtUdWuPKWU6jivVJtfRI9yGeYMlXVU0Dr0Ugglypra2uQ3ag3RxvXgdRlxkFfyAdDVIj8IAww==
X-Received: by 2002:a05:620a:1129:: with SMTP id p9mr5033995qkk.220.1583972387622;
        Wed, 11 Mar 2020 17:19:47 -0700 (PDT)
Received: from Lauras-MBP.fios-router.home (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id k14sm1719962qkh.63.2020.03.11.17.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 17:19:47 -0700 (PDT)
To:     tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
From:   Laura Abbott <laura@labbott.name>
Subject: Linux Foundation Technical Advisory Board Elections -- Change to
 charter
Message-ID: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
Date:   Wed, 11 Mar 2020 20:19:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On behalf of the Linux Foundation Technical Advisory Board (TAB), I
would like to announce the following changes to our charter, available
at https://wiki.linuxfoundation.org/tab/start

- Line 2b that previously read "All members shall be elected by a vote
amongst all invitees of the Linux Kernel Summit." is changed to "All
members shall be elected by a vote amongst all attendees of the Linux
Kernel Summit."

This clarifies that kernel summit is no longer invite only.

- Under meetings and membership, the following line is added
"The TAB, at its discretion, may set criteria to allow for absentee
voting for those who are unable to attend the Linux Kernel Summit."

For those who like diff form, this looks like

diff --git a/charter b/charter
index 45816d7..70b2e56 100644
--- a/charter
+++ b/charter
@@ -4,7 +4,8 @@
      - Promote and Support the programmes with which the TAB is charged 
to the wider Linux and Open Source Communities.
    - Meetings and Membership.
      - The TAB consists of ten voting members.
-    - All members shall be elected by a vote amongst all invitees of 
the Linux Kernel Summit.
+    - All members shall be elected by a vote amongst all attendees of 
the Linux Kernel Summit.
+    - The TAB, at its discretion, may set criteria to allow for 
absentee voting for those who are unable to attend the Linux Kernel Summit.
      - Self nominations for the election shall be accepted from any 
person, via email to the TAB mailing list, up until the time of the 
election.
      - Membership of the TAB shall be for a term of 2 years with 
staggered 1-year elections.
      - The TAB shall elect a Chair and Vice-Chair of the TAB from 
amongst their members to serve a renewable 1 year term.


This change is intended to be a follow on to last year's changes to vote
electronically instead of using paper ballots
(see 
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-July/006582.html)
We will be announcing criteria for absentee voting at a later date.

If you have any questions, feel free to speak up here or privately at
tab@lists.linuxfoundation.org.

Thanks,
Laura
