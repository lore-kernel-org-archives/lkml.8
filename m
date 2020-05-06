Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE780208D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usD4QQNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgEFOqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgEFOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:46:54 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:46:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id z17so1553232oto.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=o3F+DLGNtLRj4YOMWT2oFX2YAo4Us11+uegbWGPGt2Q=;
        b=usD4QQNjpMxIAnHFM0L1oDYKTavN3mOhnpDw2CvZFL03GQ8nrAmCS7Y/2K6cL9CjOD
         3sasUiqheTwPHVsm3vgDzVijA/kClx5HVzEGDLt5ziQAOXmukLjxZJIYktSttdDH5SgQ
         2lXjeh8e73qP93ufvvo5t2sU/9ISlnLI9E2mxysanX25SCh41AW1gC0OJWoagypAKX8I
         zNKCVmROn1sZmRyIApSuQamPyYOd4dLdAooXfGn7cJvJnpMW0fhxxG/94x6TrpaOJn7y
         yJ/2ptbDPTQXojGgtPTgQVHiYvRzc8K9MZpry6jxKjT2EZiB482qaOrZbMk2YLwb3ahN
         LOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=o3F+DLGNtLRj4YOMWT2oFX2YAo4Us11+uegbWGPGt2Q=;
        b=dYUzJ3Sxb5+vBUVCmS770KQHdjlIcZII3N83ShuWnb6Qzue2CJUSa+jvappI/dTEET
         2T3tabSMP2ssBuiZpqOjJxGGnDYuedBpKA2LX+esXg5RjvH+tOI3vIjQ7DRTE7fwk0Ww
         8R8M/em7F6rcjgkygBQuvPRi40y4NJ6MQ91kIW+cc7Ml2tU5utx/+xrg6ErcU/FLQbgd
         vPDEqn1/gfUwvv0NcxpeXtl7hzsnbJhBTFNSj3LX3ug/lry4ZxTqZ6D7kl3x5Z8R3MI5
         d38+i36SXa8xNtyR2k7vOOhv1qgb0GTiZhsXP63AOitoi6yPK0n2l5N3p1P6Vchg2P5S
         zMvA==
X-Gm-Message-State: AGi0PuadHuJBdhatHNyg1pXVKBFlodAfmBbWuZ78x20QsZqIMSP/gzYK
        kKO3bBrlicpkMgRhySeUn+YLsUSKj+0DIOWUzrw=
X-Google-Smtp-Source: APiQypLhJZzJdemTPljyt2Pc9iMfUxt+/t5yrMeZLPhmAAEMM5vZJL4yR5gApBKgWtEicOR97drSK5UU1WeUusvjTio=
X-Received: by 2002:a9d:355:: with SMTP id 79mr6336463otv.275.1588776413921;
 Wed, 06 May 2020 07:46:53 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date:   Wed, 6 May 2020 22:46:42 +0800
Message-ID: <CANTwqXAwbiGwd3-6ShQw-kvnwNPk6Ev2Sc1yMTVH4+1=mxRQsA@mail.gmail.com>
Subject: [BUG]is there a refcount leak in function mei_me_cl_rm_by_uuid?
To:     tomas.winkler@intel.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, all
When reviewing function mei_me_cl_rm_by_uuid=EF=BC=8C I notice that functio=
n
__mei_me_cl_by_uuid increases me_cl refcount
and function _mei_me_cl_del delete a list node with decrement me_cl
refcount , actually here cause a refcount leak as we haven't release
the refcount
by __mei_me_cl_by_uuid  ?
similar issue happens in mei_me_cl_rm_by_uuid_id too.

void mei_me_cl_rm_by_uuid(struct mei_device *dev, const uuid_le *uuid)
{
    struct mei_me_client *me_cl;

    dev_dbg(dev->dev, "remove %pUl\n", uuid);

    down_write(&dev->me_clients_rwsem);
    me_cl =3D __mei_me_cl_by_uuid(dev, uuid); /* increase a refcount */
    __mei_me_cl_del(dev, me_cl); /* release the refcount with a list
node deteled */
    up_write(&dev->me_clients_rwsem);
}

Best regards,

Lin Yi.
