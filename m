Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8F9C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01C720737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595005733;
	bh=9N8+ZdOzuhLEfauEOtZL3Pz3V8sOdbC0+AJJLcjfRK0=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=cChj7v7K+6xTOBpN0bdDZof4ck8iBhM5p8mjhUvvejkkFODcZ4xNCh1qNOQTmWzAl
	 6XQk1jVE4maKjXjSRCOV9DhwNpxRF1RO+7PBt9tgvGEdOA8qVdD11XURsM+raGgYkz
	 AHdLqFDt8FCCVhiHIvlqFlO2vUtugePw2hzQb15A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGQRIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgGQRIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:08:48 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18AB207DD;
        Fri, 17 Jul 2020 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595005728;
        bh=9N8+ZdOzuhLEfauEOtZL3Pz3V8sOdbC0+AJJLcjfRK0=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
        b=HroLxN4wn6+ypr6AYgjTfb75KBNwW7uUYtXK8AMHknmE7eE0v4yjtq7KxlmzOZxN0
         pVgRjoHPVYolEdUAPENqNZwTjXtRi6r38d9d9DaFRGE6Ox5XCHuZ609jpOxYCs5J4m
         RkZMjjOrzJL5xtj/wl0Y/kS/uuacO68PpZdHW2aU=
Date:   Fri, 17 Jul 2020 17:08:47 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org
Cc:     stable@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] PM / devfrq: Fix indentaion of devfreq_summary debugfs node
In-Reply-To: <20200713073112.6297-1-cw00.choi@samsung.com>
References: <20200713073112.6297-1-cw00.choi@samsung.com>
Message-Id: <20200717170847.F18AB207DD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 66d0e797bf09 ("Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs"").

The bot has tested the following trees: v5.7.8, v5.4.51, v4.19.132, v4.14.188.

v5.7.8: Build OK!
v5.4.51: Failed to apply! Possible dependencies:
    490a421bc575d ("PM / devfreq: Add debugfs support with devfreq_summary file")

v4.19.132: Failed to apply! Possible dependencies:
    490a421bc575d ("PM / devfreq: Add debugfs support with devfreq_summary file")

v4.14.188: Failed to apply! Possible dependencies:
    490a421bc575d ("PM / devfreq: Add debugfs support with devfreq_summary file")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
