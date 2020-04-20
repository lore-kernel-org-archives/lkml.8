Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB82C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC37221F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 04:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDTECT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 00:02:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbgDTECS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 00:02:18 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4BDD5C1DA6C076B8BCA0;
        Mon, 20 Apr 2020 12:02:16 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 12:02:05 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ASoC: wcd9335: remove unneeded semicolon
Date:   Mon, 20 Apr 2020 12:28:47 +0800
Message-ID: <20200420042847.19206-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

sound/soc/codecs/wcd9335.c:2606:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3619:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:2849:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:2955:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:2988:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3960:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3776:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3924:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3355:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3832:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3079:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3089:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3232:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3878:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3578:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3728:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:1922:3-4: Unneeded semicolon
sound/soc/codecs/wcd9335.c:1938:3-4: Unneeded semicolon
sound/soc/codecs/wcd9335.c:1944:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:3144:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:2568:2-3: Unneeded semicolon
sound/soc/codecs/wcd9335.c:2219:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 sound/soc/codecs/wcd9335.c | 44 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 700cc1212770..fb073f4dc7ed 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -1919,7 +1919,7 @@ static int wcd9335_hw_params(struct snd_pcm_substream *substream,
 				__func__, params_rate(params));
 			return -EINVAL;
 
-		};
+		}
 
 		ret = wcd9335_set_decimator_rate(dai, tx_fs_rate,
 						params_rate(params));
@@ -1935,13 +1935,13 @@ static int wcd9335_hw_params(struct snd_pcm_substream *substream,
 			dev_err(wcd->dev, "%s: Invalid format 0x%x\n",
 				__func__, params_width(params));
 			return -EINVAL;
-		};
+		}
 		break;
 	default:
 		dev_err(wcd->dev, "Invalid stream type %d\n",
 			substream->stream);
 		return -EINVAL;
-	};
+	}
 
 	wcd->dai[dai->id].sconfig.rate = params_rate(params);
 	wcd9335_slim_set_hw_params(wcd, &wcd->dai[dai->id], substream->stream);
@@ -2216,7 +2216,7 @@ static int wcd9335_set_compander(struct snd_kcontrol *kc,
 		break;
 	default:
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -2565,7 +2565,7 @@ static int wcd9335_micbias_control(struct snd_soc_component *component,
 							0xC0, 0x00);
 		}
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -2603,7 +2603,7 @@ static int __wcd9335_codec_enable_micbias(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMD:
 		wcd9335_micbias_control(comp, micb_num, MICB_DISABLE, true);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -2846,7 +2846,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMD:
 		snd_soc_component_update_bits(comp, tx_vol_ctl_reg, 0x10, 0x00);
 		break;
-	};
+	}
 out:
 	kfree(wname);
 	return ret;
@@ -2952,7 +2952,7 @@ static int wcd9335_codec_enable_dmic(struct snd_soc_dapm_widget *w,
 		dev_err(comp->dev, "%s: Invalid DMIC Selection\n",
 			__func__);
 		return -EINVAL;
-	};
+	}
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -2985,7 +2985,7 @@ static int wcd9335_codec_enable_dmic(struct snd_soc_dapm_widget *w,
 				dmic_rate_val << dmic_rate_shift);
 		}
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3076,7 +3076,7 @@ static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
 		dev_err(comp->dev, "%s: No gain register avail for %s\n",
 			__func__, w->name);
 		return 0;
-	};
+	}
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -3086,7 +3086,7 @@ static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3141,7 +3141,7 @@ static u16 wcd9335_interp_get_primary_reg(u16 reg, u16 *ind)
 		prim_int_reg = WCD9335_CDC_RX8_RX_PATH_CTL;
 		*ind = 8;
 		break;
-	};
+	}
 
 	return prim_int_reg;
 }
@@ -3229,7 +3229,7 @@ static int wcd9335_codec_enable_prim_interpolator(
 			wcd9335_codec_hd2_control(comp, prim_int_reg, event);
 		}
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3352,7 +3352,7 @@ static int wcd9335_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
 		wcd9335_config_compander(comp, w->shift, event);
 		wcd9335_codec_enable_prim_interpolator(comp, reg, event);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3575,7 +3575,7 @@ static int wcd9335_codec_hphl_dac_event(struct snd_soc_dapm_widget *w,
 				((hph_mode == CLS_H_LOHIFI) ?
 				 CLS_H_HIFI : hph_mode));
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3616,7 +3616,7 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 		wcd_clsh_ctrl_set_state(wcd->clsh_ctrl, WCD_CLSH_EVENT_POST_PA,
 					WCD_CLSH_STATE_EAR, CLS_H_NORMAL);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3725,7 +3725,7 @@ static int wcd9335_codec_hphr_dac_event(struct snd_soc_dapm_widget *w,
 			     WCD_CLSH_STATE_HPHR, ((hph_mode == CLS_H_LOHIFI) ?
 						CLS_H_HIFI : hph_mode));
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3773,7 +3773,7 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 		 */
 		usleep_range(5000, 5500);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3829,7 +3829,7 @@ static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
 		 */
 		usleep_range(5000, 5500);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3875,7 +3875,7 @@ static int wcd9335_codec_enable_rx_bias(struct snd_soc_dapm_widget *w,
 					WCD9335_ANA_RX_BIAS_ENABLE_MASK,
 					WCD9335_ANA_RX_BIAS_DISABLE);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3921,7 +3921,7 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 		 */
 		usleep_range(5000, 5500);
 		break;
-	};
+	}
 
 	return 0;
 }
@@ -3957,7 +3957,7 @@ static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 		usleep_range(5000, 5500);
 
 		break;
-	};
+	}
 
 	return 0;
 }
-- 
2.21.1

