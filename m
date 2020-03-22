Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C123DC4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8550920724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T46M0q8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCVQlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:41:24 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:37353 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:41:24 -0400
Received: by mail-vs1-f43.google.com with SMTP id o3so7185171vsd.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GE0sTIPTcm1eIKlinbf+AFAt+kbfaQDYpKx4gSVAaIA=;
        b=T46M0q8X0j2xrlvo/brjcErDb3qz8V0F1/aoOyCJTTZMRldI3kZV/hx3lx381qvWH5
         IJsqgLTRoxOo4O1SO4uXV08FNAZW0S5xE5u+w5wjVHIpgzZYqD7f0wDJRgvidPuQdtTI
         rgcsBj3INLKXntZ57/iVJYBMCJZGJ5YqshtIMZLdfHIb/l5VZYzMI+74W5JXWbMYf03I
         Td+5OXUMmecioltNyJQhhyNhXaPcxMtVSI/zNitGfg+1TRj4YoSVA8+5G3bsxtDMW8Fx
         TvZWAzat6W+TBeSLCPYoCwU/wsUKWqFhqRpBcqdGl479JJBrQtWaDYiEbSQkE7XutrIT
         RZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GE0sTIPTcm1eIKlinbf+AFAt+kbfaQDYpKx4gSVAaIA=;
        b=YKOprOHKdbE+6gLiLI2NZyvyg6303899VCl0t76Fhlbpm4h7DlXSnX9v/aQkq8viq9
         auaZh0Ewujc/HyHo1xGOqkhN/tOfkgTa6UsIW5n5vEzwQDb7KSYB3AYP831DBIKZ1z3W
         DRulNL5gw66gTkYoQzPY9Cm9a7gqavcVOfMq0/Ktv+lpDbmUHt0WDqc12ZkeXI1nbOgy
         IkPh/T1p4UQul4/BAyTct/jlEGzCSatkpLmO7t3GFXraLfWEMJI/W+zX+gRiKYp7LTHS
         zdbeFxObiFtjzJl1fF9iCp9oWLBf//ueyi1W4j7V5eptL3uETT3oM+RmKF4Mj54XGkBK
         IoYw==
X-Gm-Message-State: ANhLgQ2Lv8SVFFDyeBoF7G4maBKhxqMDntsAEuGHIMWKLTOAReIr8lIW
        1cFsBAQFmGxrRS5G3TjWavkzaRXCTKoPE26e+DsDHvrpdxU=
X-Google-Smtp-Source: ADFU+vuPGVj8OS7DKgC7334rvI4ih03X3uGRbn3FZzcZRr/5KK69Ggp2o/FTr6h1vyeAt9uaxtsnKDd+TckMLgWBsW0=
X-Received: by 2002:a05:6102:5ee:: with SMTP id w14mr12204529vsf.135.1584895281541;
 Sun, 22 Mar 2020 09:41:21 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?David_Bala=C5=BEic?= <xerces9@gmail.com>
Date:   Sun, 22 Mar 2020 17:41:10 +0100
Message-ID: <CAPJ9Yc-rAOai0rqpgcGv25opNVUkxAKdJBpjAvMrg-moXS3hAg@mail.gmail.com>
Subject: Oops and panic - how to debug?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(I'm not subscribed, please CC me)

I got a load of kernel errors running sysrescCD 6.1.1 64 bit on my HP
Microserver (N36L) and wonder where to proceed.

I loaded the photos of the messages here :
https://gitlab.com/fdupoux/sysresccd-src/-/issues/87

Is this something someone here can help with?

The issue raises the suspicion of a hardware problem, but Windows
2012R2 and some other (mostly older) linux distros seem to work fine.

Regards,
David
